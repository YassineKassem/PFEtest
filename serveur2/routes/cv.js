const express = require("express");
const router = express.Router();
const Cv = require("../models/cv.model");
const middleware = require("../middleware");
const multer = require("multer");
const path = require("path");
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },
  filename: (req, file, cb) => {
    cb(null, req.decoded.username + ".jpg");
  },
});

const fileFilter = (req, file, cb) => {
  if (file.mimetype == "image/jpeg" || file.mimetype == "image/png") {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 6,
  },
  // fileFilter: fileFilter,
});

//adding and update profile image
router
  .route("/add/image")
  .patch(middleware.checkToken, upload.single("img"), (req, res) => {
    Cv.findOneAndUpdate(
      { username: req.decoded.username },
      {
        $set: {
          img: req.file.path,
        },
      },
      { new: true },
      (err, profile) => {
        if (err) return res.status(500).send(err);
        const response = {
          message: "image added successfully updated",
          data: profile,
        };
        return res.status(200).send(response);
      }
    );
  });

router.route("/add").post(middleware.checkToken, (req, res) => {

  const profile = Cv({
    username: req.decoded.username,
    nom: req.body.nom,
    Prenom: req.body.Prenom,
    email: req.body.email,
    Numerotel: req.body.Numerotel,
    Adresse: req.body.Adresse,
    Codepostale: req.body.Codepostale,
    Ville: req.body.Ville,
    Profil: req.body.Profil,
    Realisation: req.body.Realisation,
    Competence: req.body.Competence,
    Formation: req.body.Formation,
    Stage: req.body.Stage,
    Ci: req.body.Ci,
    langue: req.body.langue,
  });
  profile
    .save()
    .then(() => {
      return res.json({ msg: "profile successfully stored" });
    })
    .catch((err) => {
      return res.status(400).json({ err: err });
    });
});

// Check Profile data

router.route("/checkProfile").get(middleware.checkToken, (req, res) => {
  Cv.findOne({ username: req.decoded.username }, (err, result) => {
    if (err) return res.json({ err: err });
    else if (result == null) {
      return res.json({ status: false, username: req.decoded.username });
    } else {
      return res.json({ status: true, username: req.decoded.username });
    }
  });
});

router.route("/getData").get(middleware.checkToken, (req, res) => {
  Cv.findOne({ username: req.decoded.username }, (err, result) => {
    if (err) return res.json({ err: err });
    if (result == null) return res.json({ data: [] });
    else return res.json({ data: result });
  });
});


router.route("/update").patch(middleware.checkToken, async (req, res) => {
  let profile = {};
  await Cv.findOne({ username: req.decoded.username }, (err, result) => {
    if (err) {
      profile = {};
    }
    if (result != null) {
      profile = result;
    }
  });
  Cv.findOneAndUpdate(
    { username: req.decoded.username },
    {
      $set: {     
    nom: req.body.nom ? req.body.nom : profile.nom,
    Prenom: req.body.Prenom ? req.body.Prenom : profile.Prenom ,
    email: req.body.email ? req.body.email :profile.email ,
    Numerotel: req.body.Numerotel ? req.body.Numerotel :profile.Numerotel,
    Adresse: req.body.Adresse ? req.body.Adresse :profile.Adresse,
    Codepostale: req.body.Codepostale ? req.body.Codepostale :profile.Codepostale,
    Ville: req.body.Ville ? req.body.Ville :profile.Ville,
    Profil: req.body.Profil ? req.body.Profil :profile.Profil,
    Realisation: req.body.Realisation ? req.body.Realisation :profile.Realisation,
    Competence: req.body.Competence ? req.body.Competence :profile.Competence,
    Formation: req.body.Formation ? req.body.Formation :profile.Formation,
    Stage: req.body.Stage ? req.body.Stage :profile.Stage,
    Ci: req.body.Ci ? req.body.Ci :profile.Ci,
    langue: req.body.langue ? req.body.langue :profile.langue,
      },
    },
    { new: true },
    (err, result) => {
      if (err) return res.json({ err: err });
      if (result == null) return res.json({ data: [] });
      else return res.json({ data: result });
    }
  );
});

router.route('/deleteCompetance/:index').delete(middleware.checkToken, async (req, res) => {
  let index = req.params.index
  dataUpdate=[]
    Cv.find({username:req.decoded.username}, (err, rlt) => {
      if (err) return res.json(err);  
    for (var key in rlt) {
        for(var i in rlt[key].Competence ){
          dataUpdate.push(rlt[key].Competence[i])
        }
      }
    dataUpdate.splice(index, 1); 

    Cv.findOneAndUpdate(
        { username: req.decoded.username },
        {
          $set: {     
            Competence: dataUpdate
          },
        },
        { new: true },
        (err, result) => {
          if (err) return res.json({ err: err });
          if (result == null) return res.json({ data: [] });
          else return res.json({ data: result });
        }
      );
  });
})


module.exports = router;

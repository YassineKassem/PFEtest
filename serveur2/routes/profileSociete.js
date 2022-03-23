const express = require("express");
const router = express.Router();
const ProfileS = require("../models/profileSociete.model");
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
    ProfileS.findOneAndUpdate(
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

  const profile = ProfileS({
    username: req.decoded.username,
    nom: req.body.nom,
    SecteurActivite: req.body.SecteurActivite,
    CodeFiscal: req.body.CodeFiscal,
    Email: req.body.Email,
    EmailR: req.body.EmailR,
    CodePostal: req.body.CodePostal,
    tel: req.body.tel,

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
  ProfileS.findOne({ username: req.decoded.username }, (err, result) => {
    if (err) return res.json({ err: err });
    else if (result == null) {
      return res.json({ status: false, username: req.decoded.username });
    } else {
      return res.json({ status: true, username: req.decoded.username });
    }
  });
});

router.route("/getData").get(middleware.checkToken, (req, res) => {
  ProfileS.findOne({ username: req.decoded.username }, (err, result) => {
    if (err) return res.json({ err: err });
    if (result == null) return res.json({ data: [] });
    else return res.json({ data: result });
  });
});

router.route("/update").patch(middleware.checkToken, async (req, res) => {
  let profile = {};
  await ProfileS.findOne({ username: req.decoded.username }, (err, result) => {
    if (err) {
      profile = {};
    }
    if (result != null) {
      profile = result;
    }
  });
  ProfileS.findOneAndUpdate(
    { username: req.decoded.username },
    {
      $set: {     
    nom: req.body.nom ? req.body.nom : profile.nom,
    SecteurActivite: req.body.SecteurActivite ? req.body.SecteurActivite : profile.SecteurActivite ,
    CodeFiscal: req.body.CodeFiscal ? req.body.CodeFiscal :profile.CodeFiscal ,
    Email: req.body.Email ? req.body.Email :profile.Email,
    EmailR: req.body.EmailR ? req.body.EmailR :profile.EmailR,
    CodePostal: req.body.CodePostal ? req.body.CodePostal :profile.CodePostal,
    tel: req.body.tel ? req.body.tel :profile.tel,
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
module.exports = router;

const express = require("express");
const router = express.Router();
const offreStage = require("../models/offreStage.model")
const middleware = require("../middleware");
const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },
  filename: (req, file, cb) => {
    cb(null, req.params.id + ".jpg");
  },
});

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 6,
  },
});

/*router
  .route("/add/coverImage/:id")
  .patch(middleware.checkToken, upload.single("img"), (req, res) => {
    offreStage.findOneAndUpdate(
      { _id: req.params.id },
      {
        $set: {
          coverImage: req.file.path,
        },
      },
      { new: true },
      (err, result) => {
        if (err) return res.json(err);
        return res.json(result);
      }
    );
    });*/
router.route("/Add").post(middleware.checkToken, (req, res) => {
  const offre = offreStage({
    username: req.decoded.username,
    img:`uploads/${req.decoded.username}.jpg`,
    nomOffre: req.body.nomOffre, 
    descriptionOffre: req.body.descriptionOffre, 
    localisation: req.body.localisation, 
    dateExpiration: req.body.dateExpiration,
    duree: req.body.duree 
  });
  offre
    .save()
    .then((result) => {
      res.json({ data: result });
    })
    .catch((err) => {
      console.log(err), res.json({ err: err });
    });
});

router.route("/getOwnBlog").get(middleware.checkToken, (req, res) => {
  offreStage.find({ username: req.decoded.username }, (err, result) => {
    if (err) return res.json(err);
    return res.json({ data: result });
  });
});

router.route("/getAllOffre").get((req, res) => {
  offreStage.find((err, result) => {
    if (err) return res.json(err);
    return res.json({ data: result });
  });
});

router.route("/delete/:id").delete(middleware.checkToken, (req, res) => {
  offreStage.findOneAndDelete(
    {
      $and: [{ username: req.decoded.username }, { _id: req.params.id }],
    },
    (err, result) => {
      if (err) return res.json(err);
      else if (result) {
        console.log(result);
        return res.json("Offre deleted");
      }
      return res.json("offre not deleted");
    }
  );
});

module.exports = router;
const express = require("express");
const Etudiant = require("../models/etudiants.model");
const config = require("../config");
const jwt = require("jsonwebtoken");
let middleware = require("../middleware");
const bcrypt = require("bcryptjs");
const router = express.Router();

router.route("user/:username").get(middleware.checkToken, (req, res) => {
  Etudiant.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});
router.route("/").get(middleware.checkToken, (req, res) => {
  Etudiant.findOne({ _id: req.decoded.etudiantId }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result
    });
  });
});


router.route("listFavoris/:username").get(middleware.checkToken, (req, res) => {
  Etudiant.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});

router.route("/getData").get(middleware.checkToken, (req, res) => {
  Etudiant.findOne({ _id: req.decoded.etudiantId }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result == null) return res.json({ data: [] });
    return res.json({
      data: result
    });
  })
});

router.route("/checkusername/:username").get((req, res) => {
  Etudiant.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result !== null) {
      return res.json({
        Status: true,
      });
    } else
      return res.json({
        Status: false,
      });
  });
});

router.route("/login").post(async(req, res) => {

  if (!(req.body.username && req.body.password)) {
    return res.status(400).json("All input is required");
  }
  const etd = await Etudiant.findOne({ username: req.body.username });
  if (etd && (await bcrypt.compare(req.body.password, etd.password))) {
    let token = jwt.sign({  username: req.body.username,etudiantId: etd._id }, config.key, {});
    res.status(200).json({
      token: token,
      msg: "success",
    });
  }else {
    res.status(403).json("Invalid Username/Password");
  }

});

router.route("/register").post(async (req, res) => {
  console.log("inside the register");


  encryptedPassword = await bcrypt.hash(req.body.password, 10);

  const etd = new Etudiant({
    
    username: req.body.username,
    password: encryptedPassword,
    email: req.body.email,
  });
  etd
    .save()
    .then(() => {
      console.log("user registered");
      let token = jwt.sign({  username: req.body.username,etudiantId: etd._id }, config.key, {});
      res.status(200).json({  token: token,msg: "User Successfully Registered" });
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});



router.route("/updatePwd").patch(middleware.checkToken,async(req, res) => {
  console.log(req.decoded.etudiantId);
  Etudiant.findOneAndUpdate(
    { _id: req.decoded.etudiantId },
    { $set: { password: await bcrypt.hash(req.body.password, 10)} },
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "password successfully updated",
        username: req.params.username,
      };
      return res.json(msg);
    }
  );
});

router.route("/delete/:id").delete(async(req, res) => {
  Etudiant.findOneAndDelete({ _id: req.params.id }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    const msg = {
      msg: "User deleted",
      username: req.params.username,
    };
    return res.json(msg);
  });
});

router.route("/updateEtudiant").patch(middleware.checkToken, async (req, res) => {
  Etudiant.findOneAndUpdate(
    {  _id: req.decoded.etudiantId },
    { $set: { email: req.body.email }},
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "profile successfully updated",
        email: req.body.email
      };
      return res.json(msg);
    }
  );
});

module.exports = router;

const express = require("express");
const Etudiant = require("../models/etudiants.model");
const config = require("../config");
const jwt = require("jsonwebtoken");
let middleware = require("../middleware");
const router = express.Router();

router.route("/:username").get(middleware.checkToken, (req, res) => {
  Etudiant.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
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

router.route("/login").post((req, res) => {
  Etudiant.findOne({ username: req.body.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result === null) {
      return res.status(403).json("Username incorrect");
    }
    if (result.password === req.body.password) {
      // here we implement the JWT token functionality
      let token = jwt.sign({ username: req.body.username }, config.key, {});

      res.json({
        token: token,
        msg: "success",
      });
    } else {
      res.status(403).json("password is incorrect");
    }
  });
});

router.route("/register").post((req, res) => {
  console.log("inside the register");
  const etd = new Etudiant({
    username: req.body.username,
    password: req.body.password,
    email: req.body.email,
  });
  etd
    .save()
    .then(() => {
      console.log("user registered");
      res.status(200).json({ msg: "User Successfully Registered" });
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});



router.route("/update/:username").patch((req, res) => {
  console.log(req.params.username);
  Etudiant.findOneAndUpdate(
    { username: req.params.username },
    { $set: { password: req.body.password } },
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

router.route("/delete/:username").delete((req, res) => {
  Etudiant.findOneAndDelete({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    const msg = {
      msg: "User deleted",
      username: req.params.username,
    };
    return res.json(msg);
  });
});

router.route("/updateEtudiant").patch(middleware.checkToken, async (req, res) => {
  let profile = {};
  await Etudiant.findOne({ password: req.decoded.password }, (err, result) => {
    if (err) {
      profile = {};
    }
    if (result != null) {
      profile = result;
    }
  });
  Etudiant.findOneAndUpdate(
    { password:req.decoded.password },
    {
      $set: {     
    username: req.body.username ? req.body.username : profile.username,
    email: req.body.email ? req.body.email :profile.email ,
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

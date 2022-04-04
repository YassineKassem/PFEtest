const express = require("express");
const Societe = require("../models/societes.model");
const config = require("../config");
const jwt = require("jsonwebtoken");
let middleware = require("../middleware");
const bcrypt = require("bcryptjs");
const router = express.Router();

router.route("/:username").get(middleware.checkToken, (req, res) => {
  Societe.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});

router.route("/").get(middleware.checkToken, (req, res) => {
  Societe.findOne({ _id: req.decoded.societeId }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result
    });
  });
});

router.route("/checkusername/:username").get((req, res) => {
  Societe.findOne({ username: req.params.username }, (err, result) => {
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
    return res.status(400).send("All input is required");
  }
  const soc = await Societe.findOne({ username: req.body.username });
  if (soc && (await bcrypt.compare(req.body.password, soc.password))) {
    let token = jwt.sign({ username: req.body.username,societeId: soc._id  }, config.key, {});
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

  const soc = new Societe({
    username: req.body.username,
    password: encryptedPassword,
    email: req.body.email,
  });
  soc
    .save()
    .then(() => {
      console.log("user registered");
      let token = jwt.sign({ username: req.body.username,societeId: soc._id  }, config.key, {});
      res.status(200).json({  token: token,msg: "User Successfully Registered" });
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});



router.route("/update/:username").patch(async(req, res) => {
  console.log(req.params.username);
  Societe.findOneAndUpdate(
    { username: req.params.username },
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

router.route("/delete/:username").delete((req, res) => {
  Societe.findOneAndDelete({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    const msg = {
      msg: "User deleted",
      username: req.params.username,
    };
    return res.json(msg);
  });
});

router.route("/updateSociete").patch(middleware.checkToken, async (req, res) => {
  let profile = {};
  await Societe.findOne({ password: req.decoded.password }, (err, result) => {
    if (err) {
      profile = {};
    }
    if (result != null) {
      profile = result;
    }
  });
  Societe.findOneAndUpdate(
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

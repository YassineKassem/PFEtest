const express = require("express");
const Etudiant = require("../models/etudiants.model");
const offreStage = require("../models/offreStage.model")
let middleware = require("../middleware");
const router = express.Router();


router.route("/AddFavaoris/:username/:nomOffre").patch(middleware.checkToken, async (req, res) => {
  dataUpdate=[]
  Etudiant.find({username:"uu"}, (err, rlt) => {
    if (err) return res.json(err);  

  for (doc of rlt) {
    dataUpdate.push(doc)
  }
  offreStage.find({username:req.params.username,nomOffre:req.params.nomOffre}, (err, result) => {
    if (err) return res.json(err);  
  for (const doc of result) {
    dataUpdate.push(doc)
  }
  Etudiant.findOneAndUpdate(
    { username: req.decoded.username },
    {
      $set: {     
        favorisList: dataUpdate
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

});

});

router.route("/list/:username").get(middleware.checkToken, (req, res) => {
  Etudiant.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result.favorisList,
      username: req.params.username,
    });
  });
});

  router.route("/removeFromFavoris/:username/:nomOffre").delete(middleware.checkToken, (req, res) => {
    
    Etudiant.findOneAndDelete(
            {
      $and: [{ username: req.decoded.username }, { username:req.params.username,nomOffre:req.params.nomOffre }],
          },
      (err, result) => {
        if (err) return res.json(err);
        else if (result) {
          console.log(result);
          return res.json("favoris deleted");
        }
        return res.json("favoris not deleted");
      }
    );
  });

  router.route("/removeFromFavorite").post( (req, res) => {


    Favoris.findOneAndDelete({ favorisList:req.body.favorisList })
        .exec((err, doc) => {
            if (err) return res.status(400).json({ success: false, err });
            res.status(200).json({ success: true, doc })
        })
});

  


 
  

  module.exports = router;

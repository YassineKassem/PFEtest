const express = require("express");
const Favoris = require("../models/favoris.model");
const offreStage = require("../models/offreStage.model")
let middleware = require("../middleware");
const router = express.Router();


router.route("/Add/:username/:nomOffre").post(middleware.checkToken, (req, res) => {
    offreStage.find({username:req.params.username,nomOffre:req.params.nomOffre}, (err, result) => {
        if (err) return res.json(err);
       
    const fav = Favoris({
      username: req.decoded.username,
      favorisList: result,
    });
    fav
      .save()
      .then((result) => {
        res.json({ data: result });
      })
      .catch((err) => {
        console.log(err), res.json({ err: err });
      });
  });
});

router.route("/getAllFavoris").get((req, res) => {
    Favoris.find((err, result) => {
      if (err) return res.json(err);
      
      return res.json({ data: result });
    });
  });


  router.route("/removeFromFavoris/:username/:nomOffre").delete(middleware.checkToken, (req, res) => {
    Favoris.findOneAndDelete(
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

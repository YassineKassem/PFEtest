const express = require("express");
const recommendOffre = require('../models/predictOffre.model')
let middleware = require("../middleware");
const router = express.Router();


router.route("/AddRecommendationOffre/:offreId").post(middleware.checkToken,(req, res) => {

    recommendOffre.findOne({ offreId: req.params.offreId,etudiantId:req.decoded.etudiantId}, (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      if(result==null)
        {
            const rec = recommendOffre({
              etudiantId:req.decoded.etudiantId,
              offreId:req.params.offreId,
              score:req.body.score,  
          });
          rec
            .save()
            .then((result) => {
              res.status(200).json({ data: result });
            })
            .catch((err) => {
              console.log(err), res.json({ err: err });
            });
          }
      else
        res.status(201).json('existe deja')    
  
    });  
  
    });

    router.route("/listRecommendationOffre").get( middleware.checkToken,(req, res) => {
        recommendOffre.find({etudiantId:req.decoded.etudiantId, }, (err, result) => {
          if (err) return res.status(500).json({ msg: err });
          return res.json({
            data: result,
          });
        });
      });
    
      router.route("/listRecommendationByOffre/:offreId").get( (req, res) => {
        recommendOffre.findOne({offreId:req.params.offreId, }, (err, result) => {
          if (err) return res.status(500).json({ msg: err });
          return res.json({
            data: result
          });
        });
      });
    
      



module.exports = router;
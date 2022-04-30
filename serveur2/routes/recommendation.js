const express = require("express");
const Etudiant = require("../models/etudiants.model");
const offreStage = require("../models/offreStage.model")
const postuler = require("../models/postulations.model")
const recommend = require("../models/recommendation.model")
let middleware = require("../middleware");
const router = express.Router();
var request = require('request-promise');

router.route("/AddRecommendation/:idPostulation").post(middleware.checkToken,(req, res) => {

    recommend.findOne({ postulationId: req.params.idPostulation}, (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      if(result==null)
        {
            const rec = recommend({
              societeId:req.decoded.societeId,
              postulationId:req.params.idPostulation,
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


    
router.route("/listRecommendation").get( middleware.checkToken,(req, res) => {
    recommend.find({ societeId:req.decoded.societeId}, (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      return res.json({
        data: result,
      });
    });
  });

  router.route("/listRecommendationByPostulation/:idPost").get( (req, res) => {
    recommend.findOne({postulationId:req.params.idPost }, (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      return res.json({
        data: result
      });
    });
  });

  
  

module.exports = router;
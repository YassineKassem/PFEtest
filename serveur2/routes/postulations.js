const express = require("express");
const Etudiant = require("../models/etudiants.model");
const offreStage = require("../models/offreStage.model")
const postuler = require("../models/postulations.model")
let middleware = require("../middleware");
const router = express.Router();


router.route("/AddPostulation/:idOffre").post(middleware.checkToken, (req, res) => {
  const dataOffre=[]
  postuler.find({ etudiantId: req.decoded.etudiantId}, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    for (const doc of result) {
      dataOffre.push(doc.offreId.toString())
    }
    console.log(dataOffre)

    if(dataOffre.indexOf(req.params.idOffre.toString())=== -1)
       {
          const postule = postuler({
            etudiantId:req.decoded.etudiantId,
            offreId:req.params.idOffre,
            message:req.body.message, 
            objet:req.body.objet, 
        });
        postule
          .save()
          .then((result) => {
            res.json({ data: result });
          })
          .catch((err) => {
            console.log(err), res.json({ err: err });
          });
        }
    else
      res.json('existe deja')    

  });  

  });
  

router.route("/listPostulation").get( (req, res) => {
  postuler.find({ }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
    });
  });
});

router.route("/PostulationByOffre/:idOffre").get( (req, res) => {

  postuler.find({ offreId: req.params.idOffre}, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
    });
  });
});

router.route("/PostulationByEtd/:idEtd").get( (req, res) => {

  postuler.find({ etudiantId: req.params.idEtd}, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
    });
  });
});

router.route("/PostulationByToken").get(middleware.checkToken,(req, res) => {
  let dataOffre=[]
  Etudiant.findOne({ username: req.decoded.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    var idEtd= result._id
    postuler.find({ etudiantId: idEtd}, (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      return res.json({
        data: result,
      });
    });
  });

});


router.route("/PostulationByTokenOffre").get(middleware.checkToken,(req, res) => {
  
  Etudiant.findOne({ username: req.decoded.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    var idEtd= result._id
    postuler.find({ etudiantId: idEtd}, async  (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      else{
        var dataOffre=[]
        for (const doc of result) {
        var id= doc.offreId
        console.log(id)
        const offre = await offreStage.findById(id)
        dataOffre.push(offre);
        }
        return res.json({data:dataOffre });
      }

    });
  });
});

  module.exports = router;
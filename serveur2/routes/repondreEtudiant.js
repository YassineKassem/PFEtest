const express = require("express");
const postuler = require("../models/postulations.model")
const repondre = require("../models/repondreEtudiant.model")
let middleware = require("../middleware");
const router = express.Router();


router.route("/AddReponse/:idPostulation").post(middleware.checkToken, (req, res) => {
  const dataPostulation=[]
  repondre.find({ societeId: req.decoded.societeId}, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    for (const doc of result) {
        dataPostulation.push(doc.postulationId.toString())
    }
    console.log(dataPostulation)

    if(dataPostulation.indexOf(req.params.idPostulation.toString())=== -1)
       {
          const reponse = repondre({
            societeId:req.decoded.societeId,
            postulationId:req.params.idPostulation,
            message:req.body.message, 
            objet:req.body.objet,
            date: req.body.date,
        });
        reponse
          .save()
          .then((result) => {
            res.json({ data: result });
          })
          .catch((err) => {
            console.log(err), res.json({ err: err });
          });
        }
    else
      res.json('Vous avez deja repondre ce etudiant')    

  });  

  });
  

router.route("/listReponse").get( (req, res) => {
  repondre.find({ }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
    });
  });
});

router.route("/ReponseByPostulation/:idPostulation").get( (req, res) => {

  repondre.find({ postulationId: req.params.idPostulation}, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
    });
  });
});

router.route("/ReponseByEtudiant/:idEtd").get( (req, res) => {
    const idPostulation=[]
    postuler.find({ etudiantId: req.params.idEtd},async (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    for (const doc of result) {
        console.log(doc)
        console.log(doc._id)
        idPostulation.push(doc._id.toString())
    }
    console.log(idPostulation)
    var listReponse=[]
    for(let i=0;i<idPostulation.length;i++)
    {
        const reponse = await repondre.findOne({postulationId:idPostulation[i]}) 
        console.log(reponse)
        if(reponse!=null)
          listReponse.push(reponse);

    }
    return res.json({data:listReponse});

    });
  });

  module.exports = router;

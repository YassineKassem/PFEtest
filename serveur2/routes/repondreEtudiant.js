const express = require("express");
const offreStage = require("../models/offreStage.model")
const Etudiant = require("../models/etudiants.model");
const postuler = require("../models/postulations.model")
const repondre = require("../models/repondreEtudiant.model")
let middleware = require("../middleware");
const pushNotificationController = require("../controllers/push-notification.controllers");
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

  router.route("/listReponseEtd").get(middleware.checkToken,(req, res) => {

      postuler.find({ etudiantId:req.decoded.etudiantId }, async  (err, result) => {
        if (err) return res.status(500).json({ msg: err });
        else{
          var dataPostulation=[]
          var dataOffre=[]
          for (const doc of result) {
          var id= doc._id    
          dataPostulation.push(id);
          var idoffre= doc.offreId   
          dataOffre.push(idoffre);
          }
          var datareponse=[]
          var dataoffreReponse=[]
          for (const i of dataPostulation) {
            const reponse = await repondre.findOne({ postulationId: i})
            console.log(reponse) 
            if(reponse!=null)
             datareponse.push(reponse);
          }
          return res.json({data:datareponse });
        }
      });
  });


  router.route("/listReponseEtdOffre").get(middleware.checkToken,(req, res) => {

    postuler.find({ etudiantId:req.decoded.etudiantId }, async  (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      else{
        var dataPostulation=[]
        var dataOffre=[]
        for (const doc of result) {
        var id= doc._id    
        dataPostulation.push(id);
        var idoffre= doc.offreId   
        dataOffre.push(idoffre);
        }
        var datareponse=[]
        var dataoffreReponse=[]
        for (const i of dataPostulation) {
          const reponse = await repondre.findOne({ postulationId: i})
          console.log(reponse) 
          if(reponse!=null)
           {datareponse.push(reponse);
            const offre = await postuler.findOne({ _id: i})
            const detailoffre = await offreStage.findOne({ _id: offre.offreId})
            dataoffreReponse.push(detailoffre);
          }
        }
        return res.json({
          data:dataoffreReponse });
      }
    });
});













  router.get("/sendNotification", pushNotificationController.SendNotification);

  router.post("/sendNotificationToDevice", pushNotificationController.SendNotificationToDevice);

  module.exports = router;

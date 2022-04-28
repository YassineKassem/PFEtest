const express = require("express");
const Etudiant = require("../models/etudiants.model");
const offreStage = require("../models/offreStage.model")
const postuler = require("../models/postulations.model")
const recommend = require("../models/recommendation.model")
let middleware = require("../middleware");
const router = express.Router();
var request = require('request-promise');
var ObjectId = require('mongodb').ObjectID;

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
  

router.route("/listPostulation").get( (req, res) => {
  postuler.find({ }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
    });
  });
});

//used for the recommendation cote société
router.route("/PostulationByOffre/:idOffre").get( (req, res) => {
  postuler.find({ offreId: req.params.idOffre},async (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result
      //offreid: req.params.idOffre
    });
  });
});

//used for the recommendation cote société
router.route("/PredictBestCondidates/:idOffre").get( (req, res) => {
  etudiantList=[]
  postulationList=[]
  postuler.find({ offreId: req.params.idOffre},async (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    for(const doc of result){
      var id =doc.etudiantId
      etudiantList.push(id)
      var post =doc._id
      postulationList.push(post)
    }
    const offre = await offreStage.findById(req.params.idOffre)
    
    var data = {
      array: etudiantList,
      offreDetail:offre
  }

  var options = {
      method: 'POST',

      // http:flaskserverurl:port/route
      uri: 'http://0.0.0.0:8080/getStudentId',
      body: data,

      // Automatically stringifies
      // the body to JSON 
      json: true
  };
      var sendrequest = await request(options)
    
          // The parsedBody contains the data
          // sent back from the Flask server 
          .then(function (parsedBody) {
              for(let i=0;i<etudiantList.length;i++){
                 console.log(
                  parsedBody[i]['Match Percentage']
                 )
                 recommend.findOne({ postulationId: postulationList[i]}, (err, result) => {
                  if (err) return res.status(500).json({ msg: err });
                  if(result==null)
                    {
                        const rec = recommend({
                          societeId:offre._id,
                          postulationId:postulationList[i],
                          score:parsedBody[i]['Match Percentage'],  
                      });
                      rec
                        .save()
                        .then((result) => {
                          console.log(result)
                        })
                        .catch((err) => {
                          console.log(err), res.json({ err: err });
                        });
                      }
                  else
                  console.log('existe deja')    
              
                });  
              } 

              
          })
          .catch(function (err) {
              console.log(err);
          });
          
    return res.status(200).json({
      data: result,
      offreid: req.params.idOffre
    });
  });
});

router.route("/getEtudiantOffre/:idOffre").get( (req, res) => {
  var etudiantList=[]
  postuler.find({ offreId: req.params.idOffre}, async(err, result) => {
    if (err) return res.status(500).json({ msg: err });
    else{
      
      for(const doc of result){
      var id =doc.etudiantId
      console.log(id)
      const etd = await Etudiant.findOne(id)
      etudiantList.push(etd)
    
    }
    return res.json({data:etudiantList });
    }
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

router.route("/delete/:idPostulation").delete((req, res) => {
  postuler.findOneAndDelete(
    {
       _id: req.params.idPostulation 
    },
     async(err, result) => {
      if (err) return res.json(err);
      return res.json("postulation supprimer");
      }

  );
});

router.route("/PostulationByEtdAndOffre/:idEtd/:idOffre").get( (req, res) => {

  postuler.findOne({ etudiantId: req.params.idEtd, offreId: req.params.idOffre}, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
    });
  });
});

router.route("/PostulationByid/:idPost").get( (req, res) => {
  
  postuler.findOne({ _id:ObjectId(req.params.idPost)},async (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result
    });
  });
});





  module.exports = router;

const express = require("express");
const router = express.Router();
const offreStage = require("../models/offreStage.model")
const postuler = require("../models/postulations.model")
const middleware = require("../middleware");
const multer = require("multer");


router.route("/Add").post(middleware.checkToken, (req, res) => {
  const offre = offreStage({
    username: req.decoded.username,
    societeId: req.decoded.societeId,
    img:`uploads/${req.decoded.username}.jpg`,
    nomOffre: req.body.nomOffre, 
    descriptionOffre: req.body.descriptionOffre, 
    localisation: req.body.localisation, 
    dateExpiration: req.body.dateExpiration,
    duree: req.body.duree ,
    motClee: req.body.motClee,
  });
  offre
    .save()
    .then((result) => {
      res.json({ data: result });
    })
    .catch((err) => {
      console.log(err), res.json({ err: err });
    });
});

router.route("/getOwnOffre").get(middleware.checkToken, (req, res) => {
  offreStage.find({ societeId: req.decoded.societeId }, (err, result) => {
    if (err) return res.json(err);
    return res.json({ data: result });
  });
});

router.route("/getAllOffre").get((req, res) => {
  offreStage.find((err, result) => {
    if (err) return res.json(err);
    return res.json({ data: result });
  });
});

router.route('/api/query').get((req, res) => {
  offreStage.find((err, result) => {
    if (err) return res.json(err);

  console.log(result) ; 
  const descriptionOffre = req.query.descriptionOffre.toLowerCase()
  
  const products_result = Object.values(result).filter(result => result.descriptionOffre.toLowerCase().includes(descriptionOffre))

  if (products_result.length < 1) {
      return res.status(200).send('No products matched your search')
  }
  res.json(products_result)
});
});


router.route("/search").get((req, res, next) => {
  var q=req.query.descriptionOffre;

  offreStage.find(
    {
      descriptionOffre:{
        $regex: /ali/i
      }
    },
    {
      _id:0,
      __v:0
    },
    function(err,data){
      res.json(data);

    }
  ).limit(2)
});


router.route("/search1/:cle").get(async(req, res) => {
  const motCle = req.params.cle

  const result = offreStage.aggregate(
    [
      {
        "$search":{
          "index":"chercher",
          "text":{            
            "query":motCle,           
            "path":"motClee.cle"
          }        
        }
      }
    ]
  )
  var list =[]
  for await (const doc of result) {
    list.push(doc)
  }
  if (list.length > 0)
    return res.status(200).json({ data: list });
  else
    return res.status(201).json({ data: [] }) 
  
});





router.route("/search2").get(async(req, res) => {

  const result = offreStage.find( { $text: { $search: "ecole", $language: "fr" } } )

  var list =[]
  for await (const doc of result) {
    list.push(doc)
  }
  if (list.length > 0)
    return res.json(list)
  else
    return res.json("liste vide") 
  
});


router.route("/delete/:id").delete(middleware.checkToken, (req, res) => {
  offreStage.findOneAndDelete(
    {
      $and: [{ societeId: req.decoded.societeId }, { _id: req.params.id }],
    },
     async(err, result) => {
      if (err) return res.json(err);
      else if (result){
        await postuler.deleteMany({offreId: req.params.id})
        return res.json("offre et ses postulation correspondant supprimer");

      }
      return res.json("offre supprimer");
    }
  );
});

module.exports = router;
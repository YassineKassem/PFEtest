const express = require("express");
const router = express.Router();
const offreStage = require("../models/offreStage.model")
const middleware = require("../middleware");
const multer = require("multer");

router.route("/Add").post(middleware.checkToken, (req, res) => {
  const offre = offreStage({
    username: req.decoded.username,
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

router.route("/getOwnBlog").get(middleware.checkToken, (req, res) => {
  offreStage.find({ username: req.decoded.username }, (err, result) => {
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


router.route("/search1").get(async(req, res) => {
  const result = offreStage.aggregate(
    [
      {
        "$search":{
          "text":{
            "query":"ali ecole",
            
            "path":"descriptionOffre"
          }
        }
      }
    ]
  )
  for await (const doc of result) {
    res.json(doc)
}
  
});





router.route("/delete/:id").delete(middleware.checkToken, (req, res) => {
  offreStage.findOneAndDelete(
    {
      $and: [{ username: req.decoded.username }, { _id: req.params.id }],
    },
    (err, result) => {
      if (err) return res.json(err);
      else if (result) {
        console.log(result);
        return res.json("Offre deleted");
      }
      return res.json("offre not deleted");
    }
  );
});

module.exports = router;
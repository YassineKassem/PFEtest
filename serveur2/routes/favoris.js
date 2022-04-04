const express = require("express");
const Etudiant = require("../models/etudiants.model");
const offreStage = require("../models/offreStage.model")
let middleware = require("../middleware");
const router = express.Router();


router.route("/AddFavaoris/:username/:nomOffre").patch(middleware.checkToken, async (req, res) => {
  dataUpdate=[]
  Etudiant.find({_id: req.decoded.etudiantId}, (err, rlt) => {
    if (err) return res.json(err);  
  
  for (var key in rlt) {
    for(var i in rlt[key].favorisList ){
      dataUpdate.push(rlt[key].favorisList[i])
    }
  }
  offreStage.find({username:req.params.username,nomOffre:req.params.nomOffre}, (err, result) => {
    if (err) return res.json(err); 
  
  for (const doc of result) {
    if(dataUpdate.some(e => e.nomOffre === req.params.nomOffre))
    {
      console.log("existe deja")
    }
    else
      dataUpdate.push(doc)  
  }
  Etudiant.findOneAndUpdate(
    { _id: req.decoded.etudiantId },
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

router.route("/list").get(middleware.checkToken, (req, res) => {
  Etudiant.findOne({ _id: req.decoded.etudiantId }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result.favorisList,
      username: req.params.username,
    });
  });
});

router.route("/removeFromFavoris/:username/:nomOffre").delete(middleware.checkToken, (req, res) => {
  dataUpdate=[]
  Etudiant.find({_id: req.decoded.etudiantId}, (err, rlt) => {
    if (err) return res.json(err);  
  for (var key in rlt) {
      for(var i in rlt[key].favorisList ){
        dataUpdate.push(rlt[key].favorisList[i])
      }
    }

  
  for(let i=0; i<dataUpdate.length;i++)
  {
    if(dataUpdate[i].username == req.params.username && dataUpdate[i].nomOffre == req.params.nomOffre)
      dataUpdate.splice(i, 1); 
  }

  Etudiant.findOneAndUpdate(
      { _id: req.decoded.etudiantId},
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


  module.exports = router;

const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const offreStage = Schema({
  username: String,
  img: {type: String,default:""},
  nomOffre:{ type: String, default: null } , 
  descriptionOffre:{ type: String, default: null } ,
  localisation:{ type: String, default: null } ,
  dateExpiration:{ type: Date, default: null } ,
  duree:{ type: String, default: null} 
  
});

module.exports = mongoose.model("offreStage", offreStage);
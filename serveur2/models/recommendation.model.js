const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const recommendation = Schema(
  { 
    societeId :{
        type: Schema.Types.ObjectId,
        ref: 'Societe'
    },  
    postulationId :{
      type: Schema.Types.ObjectId,
      ref: 'postulations'
    } ,
    score: { type: Number, default: null } 
        
  }
);

module.exports = mongoose.model("recommendation", recommendation);

const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const postulations = Schema({
  
    etudiantId :{
        type: Schema.Types.ObjectId,
        ref: 'Etdudiant'
    },
    offreId :{
        type: Schema.Types.ObjectId,
        ref: 'offreStage'
    },
    message: { type: String, default: null } , 
    objet: { type: String, default: null } 

});

module.exports = mongoose.model("postulations", postulations);
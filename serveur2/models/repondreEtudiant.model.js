const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const repondreEtudiant = Schema({
    societeId :{
        type: Schema.Types.ObjectId,
        ref: 'Societe'
    },
    postulationId :{
        type: Schema.Types.ObjectId,
        ref: 'postulations'
    },
    message: { type: String, default: null } , 
    objet: { type: String, default: null },
    date:   { type: Date, default: null }

});

module.exports = mongoose.model("repondreEtudiant", repondreEtudiant);
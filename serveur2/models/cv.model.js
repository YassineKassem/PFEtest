const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const Cv = Schema(

  {
    username: {
      type: String,
      required: true,
      unique: true,
    },
    nom: { type: String, default: null },
    email: { type: String, default: null},
    Prenom: { type: String, default: null },
    Numerotel: { type: Number, default: null },
    Adresse: { type: String, default: null },
    Codepostale: { type: String, default: null },
    Ville: { type: String, default: null },
    Profil: {type: String, default: null },
    Realisation: {type: String, default: null },
  
    Competence :[{ nomCompetence:{ type: String, default: null } }],
    
    Formation :[
      { 
       nomFormation: { type: String, default: null},
       etablissementF:{ type: String, default: null },
       villeF:{ type: String, default: null },
       datedF:{ type: Date, default: null },
       datefF:{ type: Date, default: null },
       DescriptionF:{ type: String, default: null } 
       }],
  
    Stage :[{ nomSociete: { type: String, default: null }, 
      datedS:{ type: Date, default: null }, datefS:{ type: Date, default: null },
      DescriptionS:{ type: String, default: null }  }],
  
    CI :[{ nomCI: { type: String, default: null } }],
  
    langue :[{ nomLangue: { type: String, default: null }, NiveauLangue: { type: String, default: null } }],
  
    img:{type: String,default:""}

  },
  {
    timestamp: true,
  }
);

module.exports = mongoose.model("Cv", Cv);

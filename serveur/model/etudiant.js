const mongoose = require("mongoose");


const userSchemaEtudiantCV = new mongoose.Schema({
  nom: { type: String, default: null },
  email: { type: String, required: true, unique: true },
  Prenom: { type: String, default: null },
  Numerotel: { type: Number, default: null },
  Adresse: { type: String, default: null },
  Codepostale: { type: String, default: null },
  Ville: { type: String, default: null },
  Profile : {type: String, default: null  },
  Realisation : {type: String, default: null },
  Competance :[{ nomCompetance:{ type: String, default: null } }],
  
  Formation :[  { nomFormation: { type: String, default: null },
    etablissementF:{ type: String, default: null }, villeF:{ type: String, default: null },
     datedF:{ type: Date, default: null }, datefF:{ type: Date, default: null },
      DescriptionF:{ type: String, default: null }  }],

  Stage :[{ nomSociete: { type: String, default: null }, 
    datedS:{ type: Date, default: null }, datefS:{ type: Date, default: null },
    DescriptionS:{ type: String, default: null }  }],

  CI :[{ nomCI: { type: String, default: null } }],

  langue :[{ nomLangue: { type: String, default: null }, NiveauLangue: { type: String, default: null } }],

  image:{type: String,default: null}

 
});


const userSchemaEtudiant = new mongoose.Schema({
  name: { type: String, default: null },
  email: { type: String, unique: true },
  password: { type: String },
  token: { type: String },
  detailEtd : [
    userSchemaEtudiantCV
  ],
  
});

module.exports = mongoose.model("etudiant", userSchemaEtudiant);


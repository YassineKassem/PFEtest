const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const profileSociete = Schema(

  {
    username: {
      type: String,
      required: true,
      unique: true,
    },
    nom: { type: String, default: null },
    SecteurActivite: { type: String, default: null },
    CodeFiscal: { type: String, default: null },
    Email: { type: String, default: null },
    EmailR: { type: String, default: null },
    CodePostal: { type: String, default: null },
    tel: { type: Number, default: null },
    img:{type: String,default:""}

  },
  {
    timestamp: true,
  }
);

module.exports = mongoose.model("profileSociete", profileSociete);

const mongoose = require("mongoose");


const userSchemaSociete = new mongoose.Schema({
    telephone: { type: Number, default: null, minimum: 10000000,maximum: 100000000, exclusiveMaximum: true },
    email: { type: String, unique: true },
    password: { type: String },
    token: { type: String },
  });
  
  module.exports = mongoose.model("societe", userSchemaSociete);
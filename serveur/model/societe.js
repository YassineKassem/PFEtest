const mongoose = require("mongoose");


const userSchemaSociete = new mongoose.Schema({
    name: { type: String , default: null},
    email: { type: String, unique: true },
    password: { type: String },
    token: { type: String },
  });
  
  module.exports = mongoose.model("societe", userSchemaSociete);
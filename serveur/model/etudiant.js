const mongoose = require("mongoose");

const userSchemaEtudiant = new mongoose.Schema({
  name: { type: String, default: null },
  //last_name: { type: String, default: null },
  email: { type: String, unique: true },
  password: { type: String },
  token: { type: String },
});

module.exports = mongoose.model("etudiant", userSchemaEtudiant);


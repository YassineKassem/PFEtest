const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const Etudiant = Schema({

  username: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  favorisList :{
    type: Schema.Types.Array,
    ref: 'offreStage'
},
});

module.exports = mongoose.model("Etudiant", Etudiant);

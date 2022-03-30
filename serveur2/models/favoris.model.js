const mongoose = require("mongoose");

const Schema = mongoose.Schema;


const Favoris = Schema({

  username: String,
  favorisList :{
    type: Schema.Types.Array,
    ref: 'offreStage'
},

});

module.exports = mongoose.model("Favoris", Favoris);
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const predictOffre = Schema({ 

etudiantId :{
    type: Schema.Types.ObjectId,
    ref: 'Etdudiant'
},
offreId :{
    type: Schema.Types.ObjectId,
    ref: 'offreStage'
},
score: { type: Number, default: null } 
        
});

module.exports= mongoose.model("predictOffre", predictOffre)




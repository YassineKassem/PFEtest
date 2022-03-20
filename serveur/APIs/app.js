require("dotenv").config();
require("../config/database").connect();
const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const multer=require('multer')
const router = express.Router();
const etudiant = require("../model/etudiant");
const societe = require("../model/societe");
const CV = require("../model/CV");
const auth = require("../middleware/auth");
const path = require("path");
const app = express();

app.use(express.json({ limit: "50mb" }));


const storage = multer.diskStorage({
  destination : (req,file,cb) => {
    cb(null, "./uploads");
  },
  filename: (req,file,cb) =>{
    cb(null,req.params.id +".jbg");
  }
  });

  const fileFilter = (req,file,cb)=>{
    if(file.mimetype == "image/jpeg" || file.mimetype == "image/png" )
    {  cb(null,true);}
    else
    {cb(null,false);  }

    };
  

const upload = multer({
storage:storage,
limits:{
  fileSize : 1024*1024*6,
},
fileFilter : fileFilter,
});



app.patch("/add/image/:id", upload.single("image"),async (req,res)=> {
   await CV.findOneAndUpdate(
    req.params.id,
    {
      $set:{
        image: req.file.path,
      },
    },

      {new: true},
      (err, CV) => {
        if (err) return res.status(500).send(err);
        const response = {
          message: "image added successfully updated",
          data: CV,
        };
        return res.status(200).send(response);
      }
    
   );
});

app.use("/uploads",express.static("uploads"));



app.post("/etudiant/register", async (req, res) => {
  try {
    // Get user input
    const {name, email, password } = req.body;

    // Validate user input
    if (!(email && password && name)) {
      return res.status(400).send("All input is required");
    }

    // check if user already exist
    // Validate if user exist in our database
    const oldEtudiant = await etudiant.findOne({ email });

    if (oldEtudiant) {
      return res.status(409).send("etudiant Already Exist. Please Login");
    }

    //Encrypt user password
    encryptedPassword = await bcrypt.hash(password, 10);

    // Create user in our database
    const etd = await etudiant.create({
      name,
      email: email.toLowerCase(), // sanitize: convert email to lowercase
      password: encryptedPassword,
    });

    // Create token
    const token = jwt.sign(
      { etd_id: etd._id, email },
      process.env.TOKEN_KEY,
      {
        expiresIn: "2h",
      }
    );
    // save user token
    etd.token = token;

    // return new user
    return res.status(201).json(etd);
  } catch (err) {
    console.log(err);
  }
});

app.post("/etudiant/login", async (req, res) => {
  try {
    // Get user input
    const { email, password } = req.body;

    // Validate user input
    if (!(email && password)) {
      return res.status(400).send("All input is required");
    }
    // Validate if user exist in our database
    const etd = await etudiant.findOne({ email });

    if (etd && (await bcrypt.compare(password, etd.password))) {
      // Create token
      const token = jwt.sign(
        { etd_id: etd._id, email },
        process.env.TOKEN_KEY,
        {
          expiresIn: "2h",
        }
      );

      // save user token
      etd.token = token;

      // user
      return res.status(200).json(etd.token);
    }
    return res.status(400).send("Invalid Credentials");
  } catch (err) {
    console.log(err);
  }
});

app.get("/etudiant/welcome", auth, (req, res) => {
  
  res.status(200).send("Welcome student🙌 ");


});



//partie login et auth societe


app.post("/societe/register", async (req, res) => {
  try {
    // Get user input
    const { name, email, password } = req.body;

    // Validate user input
    if (!(email && password && name)) {
      return res.status(400).send("All input is required");
    }

    // check if user already exist
    // Validate if user exist in our database
    const oldSociete = await societe.findOne({ email });

    if (oldSociete) {
      return res.status(409).send("societe Already Exist. Please Login");
    }

    //Encrypt user password
    encryptedPassword = await bcrypt.hash(password, 10);

    // Create user in our database
    const soc = await societe.create({
      name,
      email: email.toLowerCase(), // sanitize: convert email to lowercase
      password: encryptedPassword,
    });

    // Create token
    const token = jwt.sign(
      { soc_id: soc._id, email },
      process.env.TOKEN_KEY,
      {
        expiresIn: "2h",
      }
    );
    // save user token
    soc.token = token;

    // return new user
    return res.status(201).json(soc);
  } catch (err) {
    console.log(err);
  }
});

app.post("/societe/login", async (req, res) => {
  try {
    // Get user input
    const { email, password } = req.body;

    // Validate user input
    if (!(email && password)) {
      return res.status(400).send("All input is required");
    }
    // Validate if user exist in our database
    const soc = await societe.findOne({ email });

    if (soc && (await bcrypt.compare(password, soc.password))) {
      // Create token
      const token = jwt.sign(
        { soc_id: soc._id, email },
        process.env.TOKEN_KEY,
        {
          expiresIn: "2h",
        }
      );

      // save user token
      soc.token = token;

      // user
      return res.status(200).json(soc);
    }
    return res.status(400).send("Invalid Credentials");
  } catch (err) {
    console.log(err);
  }
});

app.get("/societe/welcome", auth, (req, res) => {
  res.status(200).send("Welcome societe🙌 ");
});


// insert in collection etudiant his CV
app.patch("/etudiant/CV/register/:id", async (req, res) => {
  try {

        // Get cv input
        const {nom, email,Prenom,Numerotel,Adresse,Codepostale,Ville,Profile,Realisation,Competance,Formation,Stage,CI,langue, } = req.body;

        // Validate cv input
        if (!(nom && email && Prenom && Numerotel && Adresse && Codepostale && Ville && 
          Competance && Formation && Stage && CI && langue && Profile && Realisation  )) {
          return res.status(400).send("All input is required");
        }
        
    
        // Create cv in our database
        const cv = await CV.create({
          nom,
          Prenom,
          email,
          Numerotel,
          Adresse,
          Codepostale,
          Ville,
          Profile,
          Realisation,
          Competance,
          Formation,
          Stage,
          CI,
          langue,
         
        }); 
        
    await etudiant.findByIdAndUpdate(
      req.params.id,
      {
        $set:{
          detailEtd : [
            cv
          ],
        },
      },
  
        {new: true},
        (err, etudiant) => {
          if (err) return res.status(500).send(err);
          const response = {
            message: "etudiant successfully updated",
            data: etudiant,
          };
          return res.status(200).send(response);
        }
      
     );

  } catch (err) {
    console.log(err);
  }
});

// insert in collection etudiant his part 1 of CV
app.patch("/etudiant/CV/part1/register/:id", async (req, res) => {
  try {

        // Get cv input
        const {nom, email,Prenom,Numerotel,Adresse,Codepostale,Ville,Profile} = req.body;

        // Validate cv input
        if (!(nom && email && Prenom && Numerotel && Adresse && Codepostale && Ville && Profile)) {
          return res.status(400).send("All input is required");
        }
        
        // Create cv in our database
        const cv = await CV.create({
          nom,
          Prenom,
          email,
          Numerotel,
          Adresse,
          Codepostale,
          Ville,
          Profile
        }); 
        
    await etudiant.findByIdAndUpdate(
      req.params.id,
      {
        $set:{
          detailEtd : [
            cv
          ],
        },
      },
        {new: true},
        (err, etudiant) => {
          if (err) return res.status(500).send(err);
          const response = {
            message: "etudiant successfully updated",
            data: etudiant,
          };
          return res.status(200).send(response);
        }
      
     );

  } catch (err) {
    console.log(err);
  }
});

//get all
app.get('/etudiant/CV',async (req,res) => {
  const cvv = await CV.find();
  res.json(cvv);
});

//get by id
app.get('/etudiant/CV/:id', (req,res) => {
  CV.findById(req.params.id, function (err, docs) {
    if (err){
        console.log(err);
    }
    else{
      return res.status(201).json(docs);
    }
});
});

//get by token
app.get('/etudiant',auth, (req,res) => {
  res.json(etudiant.find())
});


//get last inserted collection id from etudiant
app.get("/lastId", (req,res) => {
  etudiant.findOne({}, {}, { sort: {_id: -1 } }, function(err, post) {
    return res.status(200).send(post.id);
  });
   
});

//get last collection from etudiant
app.get("/lastCollection", (req,res) => {
  etudiant.findOne({}, {}, { sort: {_id: -1 } }, function(err, post) {
    return res.status(200).send(post);
  });
   
});


//get last inserted collection email from etudiant
app.get("/lastEmail", (req,res) => {
  etudiant.findOne({}, {}, { sort: {_id: -1 } }, function(err, post) {
    return res.status(200).send(post.email);
  });
});



// This should be the last route else any after it won't work
app.use("*", (req, res) => {
  res.status(404).json({
    success: "false",
    message: "Page not found",
    error: {
      statusCode: 404,
      message: "You reached a route that is not defined on this server",
    },
  });
});


module.exports = app;

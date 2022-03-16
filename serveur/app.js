require("dotenv").config();
require("./config/database").connect();
const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const multer=require('multer')

const etudiant = require("./model/etudiant");
const societe = require("./model/societe");
const CV = require("./model/CV");
const image = require("./model/image");
const auth = require("./middleware/auth");

const app = express();

app.use(express.json({ limit: "50mb" }));

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
      return res.status(200).json(etd);
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

//image

app.use('/uploads', express.static(__dirname +'/uploads'));
var storage = multer.diskStorage({
   destination: function (req, file, cb) {
     cb(null, 'uploads')
   },
   filename: function (req, file, cb) {
     cb(null, new Date().toISOString()+file.originalname)
   }
 })
  
 var upload = multer({ storage: storage })
 app.post('/upload', upload.single('myFile'), async(req, res, next) => {
   const file = req.file
   if (!file) {
     const error = new Error('Please upload a file')
     error.httpStatusCode = 400
     return next("hey error")
   }
     
     
     const imagepost= new model({
       image: file.path
     })
     const savedimage= await imagepost.save()
     res.json(savedimage)
   
 })

 app.get('/image', (req, res)=>{
  const image =   image.find()
  res.json(image)
  
 })


// insert in collection CV
app.post("/etudiant/CV/register", async (req, res) => {
  try {
    
    const file = req.file 
    if (!file) {
      return res.status(400).json('Please upload a image');
    } 

    // Get cv input
    const {nom, email,Prenom,Numerotel,Adresse,Codepostale,Ville,Competance,Formation,Stage,CI,langue, } = req.body;

    // Validate cv input
    if (!(nom && email && Prenom && Numerotel && Adresse && Codepostale && Ville && 
      Competance && Formation && Stage && CI && langue  )) {
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
      Competance,
      Formation,
      Stage,
      CI,
      langue,
     
    });

    // return new user
    return res.status(201).json(cv);


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

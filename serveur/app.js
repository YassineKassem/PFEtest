require("dotenv").config();
require("./config/database").connect();
const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const etudiant = require("./model/etudiant");
const societe = require("./model/societe");
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

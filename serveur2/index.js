const express = require("express");
const mongoose = require("mongoose");
const port = process.env.PORT || 5000;
const app = express();

mongoose.connect(
  "mongodb+srv://Sattagny:sattagny@cluster0.908ax.mongodb.net/Sattagny?authSource=admin&replicaSet=atlas-11ljgp-shard-0&readPreference=primary&appname=MongoDB%20Compass&ssl=true",
  {
    useNewUrlParser: true,
    useCreateIndex: true,
    useUnifiedTopology: true,
    useFindAndModify: false
  }
);

const connection = mongoose.connection;
connection.once("open", () => {
  console.log("MongoDb connected");
});

//middleware etudiant
app.use("/uploads", express.static("uploads"));
app.use(express.json());
const userRoute = require("./routes/etudiant");
app.use("/etudiant", userRoute);
const profileRoute = require("./routes/cv");
app.use("/cv", profileRoute);
const blogRoute = require("./routes/blogpost");
app.use("/blogPost", blogRoute);

//middleware societe
const userRouteS = require("./routes/societe");
app.use("/societe", userRouteS);
const profileRouteS = require("./routes/profileSociete");
app.use("/profileSociete", profileRouteS);


data = {
  msg: "Welcome on DevStack Blog App development YouTube video series",
  info: "This is a root endpoint",
  Working: "Documentations of other endpoints will be release soon :)",
  request:
    "Hey if you did'nt subscribed my YouTube channle please subscribe it",
};

app.route("/").get((req, res) => res.json(data));

app.listen(port, "0.0.0.0", () =>
  console.log(`welcome your listinnig at port ${port}`)
);

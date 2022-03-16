const jwt = require("jsonwebtoken");

const config = process.env;

const verifyToken = (req, res, next) => {
  const token =
    req.body.token || req.query.token || req.headers["x-access-token"];

  if (!token) {
    return res.status(403).send("A token is required for authentication");
  }
  try {
    const decoded = jwt.verify(token, config.TOKEN_KEY);
    req.user = decoded;
  } catch (err) {
    return res.status(401).send("Invalid Token");
  }
  return next();
};

const checkToken = (req, res, next)=>{
let token = req.headers["authorization"];
console.log(token);
token = token.slice(7, token.length);
if(token){
  jwt.verify(token, config.key, (err, decoded)=>{
    if(err){
      return res.json({
        status: false,
        msg: "token is invalid"
      });
    }else{
      req.decoded = decoded;
      next();
    }
  });
}else{
  return res.json({
    status: false,
    msg: "token is not provided"
  })
}
};


module.exports = verifyToken;

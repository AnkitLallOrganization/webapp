const bcrypt = require("bcrypt");
const dbFuncs = require('../models/dbFuncs');

const createPassHash = async (pass) => {
    const salt = await bcrypt.genSalt();
    const hashedpassword = await bcrypt.hash(pass, salt);
    return hashedpassword
}

const bAuthCheck = async (req, res, next) => {

    if (!req.headers.authorization || req.headers.authorization.indexOf("Basic ") === -1) {
      return res.status(401).json({ message: "Unauthorized" });
    }
  
    const base64Creds = req.headers.authorization.split(" ")[1];
    const credentials = Buffer.from(base64Creds, "base64").toString(
      "ascii"
    );
  
    const userName = credentials.split(":")[0];
    const pass = credentials.split(":")[1];
    const id = req.params.id;

    let userAccCheck = await validUser(userName, pass);
  
    if (!userName || !pass || !userAccCheck) {
      return res.status(401).json({
        message: "Unauthorized",
      });
    } 
    
    let dbCheck = await dbCredVal(userName, pass,id);
    if(dbCheck) {
        return res.status((dbCheck=='Forbidden')?403:400).json({
          message: dbCheck,
        });
    }
  
    next();
  }

  const validateEmail = (uName) => {
    var reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if (uName.match(reg)) {
      return true;
    }

    return false;
  }

  const validUser = async (userName, pass) => {
    let check = true;
    let result = await dbFuncs.getUserDataCreds(userName);
    if (!result) {
        return false;
    }

    let passCheck = await bcrypt.compare(pass, result.password);
    if(!passCheck) {
      return false;
    }

    return true;
  }
  
  const dbCredVal = async (userName, pass, id) => {
    let result = await dbFuncs.getUserData(id);
    if (!result) {
        return 'Bad Request';
    }

    let {username, password} = result;
    let passCheck = await bcrypt.compare(pass, password);
    if(username !== userName || !passCheck) {
      return 'Forbidden';
    }

    return '';
  }

module.exports = {
    createPassHash,
    bAuthCheck,
    dbCredVal,
    validateEmail,
    validUser
}
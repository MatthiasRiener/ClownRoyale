var db = require('../db/dbConfig');
var jwt = require('jsonwebtoken');


function createUser(access_token) {
    console.log("Creating user...");
    console.log(db);
    const data = getInfoFromToken(access_token);
}

function getInfoFromToken(token) {
    var decoded = jwt.decode(token, { complete: true });
    console.log(decoded);
    console.log("=====")
    console.log(decoded.header);
    console.log("====")
    console.log(decoded.payload)

    return decoded;
}

module.exports.createUser = createUser;
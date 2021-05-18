var db = require('../db/dbConfig');
var jwt = require('jsonwebtoken');

const schema = new db.Schema({ _id: String });
const Model = db.model('user', schema);

function createUser(access_token) {
    const data = getInfoFromToken(access_token);


    if (checkIfUserExists(data.sub)) {
        console.log("Inserting user...")
    } else {
        console.log("user existiert bereits");
    }



}

function checkIfUserExists(u_id) {
    Model.exists({ name: u_id }, function (err, result) {
        if (err) {
            console.log("Error...");
            return false;
        } else {
            return result;
        }
    });
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
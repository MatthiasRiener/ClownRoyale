var db = require('../db/dbConfig');
var jwt = require('jsonwebtoken');


const Model = db.db.model('user', require('../entitiy/User'));

function createUser(access_token) {
    const data = getInfoFromToken(access_token);


    if (checkIfUserExists(data.sub)) {
        console.log("user already exists! updating time")
        Model.updateOne({_id: data.sub}, {$set: {last_login: new Date().getTime()}})
    } else {
        Model.create({
            _id: data.sub,
            name: data.preferred_username,
            mail: data.email,
            image: "https://www.einfachbacken.de/sites/einfachbacken.de/files/styles/full_width_tablet_4_3/public/2021-04/bananenbrot.jpg?h=7d326bee&itok=xchvD_0f",
            last_login: new Date().getTime()
        });
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
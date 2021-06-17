var jwt = require('jsonwebtoken');

var getJWTTOken = function (req, res) {
    return req.headers.authorization.toString().split(" ")[1];
}

var getUserID = function (req) {
    return getInfoFromToken(getJWTTOken(req)).sub;
}

function getInfoFromToken(token) {
    var decoded = jwt.decode(token, { complete: true });
    return decoded.payload;
}

async function getUserInfo(req) {
    return await require('../repository/AuthenticationRepository').getUser(getUserID(req));
}

module.exports.getJWTTOken = getJWTTOken;
module.exports.getUserID = getUserID;
module.exports.getInfoFromToken = getInfoFromToken;

module.exports.getUserInformation = getUserInfo;
var router = require('express').Router();


var AccessToken = require('twilio').jwt.AccessToken;
var VideoGrant = AccessToken.VideoGrant;

// Substitute your Twilio AccountSid and ApiKey details
var ACCOUNT_SID = 'AC82a2dbe6da739d70e5df7575ac24f350';
var API_KEY_SID = 'SK1045bfc2c9010d560f842a07c0febbc8';
var API_KEY_SECRET = '7vShsWQlueuuhU0wzZSAcVCkOfjaQ3Gh';

const { getUserID } = require('../../helper/helper');
router.use(require('../authentication/tokenMiddleware'));


router.get('/accessToken', (req, res) => {
    // Create an Access Token
    var accessToken = new AccessToken(
        ACCOUNT_SID,
        API_KEY_SID,
        API_KEY_SECRET
    );

    // Set the Identity of this token
    accessToken.identity = getUserID(req);


    // Grant access to Video
    var grant = new VideoGrant();
    var roomID = require('../game/initSocket').getRoomOfUser(getUserID(req));

    console.log("Connecting " + getUserID(req) + " to the game lobby " + roomID);

    grant.room = roomID;
    accessToken.addGrant(grant);

    // Serialize the token as a JWT
    var jwt = accessToken.toJwt();

    res.send({"tk": jwt})
})


module.exports = router;
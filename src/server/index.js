const express = require('express');
const app = express();
const port = 5000;

var AccessToken = require('twilio').jwt.AccessToken;
var VideoGrant = AccessToken.VideoGrant;

// Substitute your Twilio AccountSid and ApiKey details
var ACCOUNT_SID = 'AC82a2dbe6da739d70e5df7575ac24f350';
var API_KEY_SID = 'SK1045bfc2c9010d560f842a07c0febbc8';
var API_KEY_SECRET = '7vShsWQlueuuhU0wzZSAcVCkOfjaQ3Gh';

app.get('/', (req, res) => {
    res.send('Hallo 4CHIF!');
});


app.get('/accessToken', (req, res) => {
    // Create an Access Token
    var accessToken = new AccessToken(
        ACCOUNT_SID,
        API_KEY_SID,
        API_KEY_SECRET
    );

    // Set the Identity of this token
    accessToken.identity = Math.random().toString(36).substring(7).toString();

    // Grant access to Video
    var grant = new VideoGrant();
    grant.room = 'ClownLobby';
    accessToken.addGrant(grant);

    // Serialize the token as a JWT
    var jwt = accessToken.toJwt();

    res.send(jwt)
})


const users = ["Jan", "Lukas", "Simon", "Matthias"];
var requestCounter = 0;
app.get('/fakeLogin', (req, res) => {
    res.send({"username": users[requestCounter]})

    requestCounter == users.length - 1 ? requestCounter = 0 : requestCounter++;
})


app.post('/loginRoute', (req, res) => {
    console.log(req.body);

    res.send({"res": "Hallo alter Knabe!"})
})

app.listen(port, () => {
    console.log(`Das Herzstück des Projektes wurde soeben auf Port ${port} gestartet. `);
})


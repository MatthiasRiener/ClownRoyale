var router = require('express').Router();
const axios = require('axios');
const qs = require('qs');

router.post('/login', (req, res) => {

    const baseURL = "http://localhost:8080/auth/realms/";
    const realmName = "clown";
    const subURL = "/protocol/openid-connect/token";

    const username = req.body.username;
    const password = req.body.password;

    console.log(username, password);

    const request_options =  {
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      }

    const data = {
        "client_id": "node-client",
        "scope": "openid",
        "client_secret": "6a29eee4-de06-4492-84b7-3618a57111e8",
        "username": req.body.username,
        "password": req.body.password,
        "grant_type": "password"
    }
    
    axios.post(baseURL + realmName + subURL, qs.stringify(data) , request_options)
    .then((response) => {
        console.log(response);
        res.send({"access": response.data.access_token, "refresh": response.data.refresh_token})
    })
    .catch((error) => {
        res.send({"error": "Es gab einen Fehler!"})
        console.error(error);
    })
});

router.post('/refreshToken', (req, res) => {
    /*
        Method: POST
        URL: https://keycloak.example.com/auth/realms/myrealm/protocol/openid-connect/token
        Body type: x-www-form-urlencoded
        Form fields:    
        client_id : <my-client-name>
        grant_type : refresh_token
        refresh_token: <my-refresh-token>
        client_secret
    */
})


router.post('/register', (req, res) => {
    console.log("Register...");
    res.send({"res": 1});
})


const users = ["Jan", "Lukas", "Simon", "Matthias"];
var requestCounter = 0;
router.get('/fakeLogin', (req, res) => {
    res.send({"username": users[requestCounter]})

    requestCounter == users.length - 1 ? requestCounter = 0 : requestCounter++;
})

module.exports = router;
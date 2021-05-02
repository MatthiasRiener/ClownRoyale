var router = require('express').Router();
const axios = require('axios');

router.post('/login', (req, res) => {

    const baseURL = "http://localhost:8080/auth/realms/";
    const realmName = "clown";
    const subURL = "/protocol/openid-connect/token";

    const username = req.body.username;
    const password = req.body.username;

    console.log(username, password);

    const options = {
        "client_id": "node-client",
        "username": req.body.username,
        "password": req.body.password,
        "grant_type": "password"
    }
    
    axios.post(baseURL + realmName + subURL, options)
    .then((res) => {
        console.log(res);
    })
    .catch((error) => {
        console.error(error);
    })
    res.send({"res": 1})
});


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
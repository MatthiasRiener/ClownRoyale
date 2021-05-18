var router = require('express').Router();

const aRepo = require('../../repository/AuthenticationRepository');

const axios = require('axios');
const qs = require('qs');

const baseURL = "http://localhost:8080/auth/realms/";
const realmName = "clown";
const subURL = "/protocol/openid-connect/token";

router.post('/login', (req, res) => {



    const username = req.body.username;
    const password = req.body.password;


    if (username == undefined || username.length == 0) {
        return res.send({ "status": "Username ist ungültig." })
    }

    if (password == undefined || password.length == 0) {
        return res.send({ "status": "Passwort ist ungültig." })
    }

    console.log(username, password);

    const request_options = {
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

    axios.post(baseURL + realmName + subURL, qs.stringify(data), request_options)
        .then((response) => {
            aRepo.createUser(response.data.access_token);
            res.send({ "isLogin": true, "access": response.data.access_token, "refresh": response.data.refresh_token })
        })
        .catch((error) => {
            res.send({ "error": "Es gab einen Fehler!" })
            console.error(error);
        })
});

router.post('/refreshToken', (req, res) => {

    const refresh = req.body.refresh_token;

    const request_options = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    }

    const data = {
        "client_id": "node-client",
        "scope": "openid",
        "client_secret": "6a29eee4-de06-4492-84b7-3618a57111e8",
        "refresh_token": refresh,
        "grant_type": "refresh_token"
    }

    axios.post(baseURL + realmName + subURL, qs.stringify(data), request_options)
        .then((response) => {
            console.log(response);
            res.send({ "isRefresh": true, "access": response.data.access_token, "refresh": response.data.refresh_token })
        })
        .catch((error) => {
            res.send({ "error": "Es gab einen Fehler!" })
            console.error(error);
        })

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




/*
router.post('/register', (req, res) => {

    console.log(req.query)

    const username = req.query.username;
    const password = req.query.password;
    const email = req.query.email;


    if (username == undefined || username.length == 0) {
        return res.send({ "status": "Username ist ungültig." })
    }

    if (password == undefined || password.length == 0) {
        return res.send({ "status": "Passwort ist ungültig." })
    }









    const request_options = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    }

    const data = {
        "client_id": "admin-cli",
        "grant_type": "client_credentials",
        "client_secret": "ab4e2273-680e-4d1f-bbc7-eb914769c40b"
    }

    axios.post(baseURL + "master" + subURL, qs.stringify(data), request_options)
        .then((response) => {
            console.log("===============")


            var access = response.data.access_token;
            console.log(access)


            const request_options = {
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + access 
                }
            }

            const data = {
                "username": "greg",
                "email": "email",
                "firstName": "Max",
                "lastName": "Mustermann",
                "enabled": "true",
            }

            axios.post("http://localhost:8080/auth/admin/realms/clown/users", data, request_options)
                .then((r) => {
                    res.send({ "isLogin": true, "access": r.data.access_token, "refresh": r.data.refresh_token })
                })
                .catch((error) => {
                    res.send({ "error": "Es gab einen Fehler!" })
                    console.log(error)
                })

        })
        .catch((error) => {
            //console.error(error);
        })



})

*/
const users = ["Jan", "Lukas", "Simon", "Matthias"];
var requestCounter = 0;
router.get('/fakeLogin', (req, res) => {
    res.send({ "username": users[requestCounter] })

    requestCounter == users.length - 1 ? requestCounter = 0 : requestCounter++;
})



module.exports = router;
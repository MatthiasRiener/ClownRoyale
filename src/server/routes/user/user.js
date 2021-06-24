
var router = require('express').Router();

var getUserID = require('../../helper/helper').getUserID;
var getUserInfo = require('../../helper/helper').getUserInformation;
var getUserByRanking = require('../../repository/AuthenticationRepository').getUsersByRanking;

router.use(require('../authentication/tokenMiddleware'));

// /shop/todaysItem
router.get('/getUID', (req, res) => {
    var u_id = getUserID(req);
    res.send({"u_id": u_id})
});

router.get('/rankedUsers', (req, res) => {
     getUserByRanking().then(data => {
        console.log("results from ranked users:", data);
        res.send({"res": data})
     });
})

router.get('/getProfileInformation', (req, res) => {
    console.log("Guten Tag. Sie beantragen die Informationen.")
    getUserInfo(req).then((result) => {
        console.log(result)
        res.send({"user": result }); 
    });

})




module.exports = router;
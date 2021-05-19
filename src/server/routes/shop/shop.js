
var router = require('express').Router();

var getUserID = require('../../helper/helper').getUserID;

router.use(require('../authentication/tokenMiddleware'));

// /shop/todaysItem
router.get('/todaysItem', (req, res) => {
    var u_id = getUserID(req);
    console.log("GETTING USER_ID", u_id);
    res.send({"shop": "Todays shop is ebic."})
});


module.exports = router;

var router = require('express').Router();

var getUserID = require('../../helper/helper').getUserID;

router.use(require('../authentication/tokenMiddleware'));

// /shop/todaysItem
router.get('/getUID', (req, res) => {
    var u_id = getUserID(req);
    res.send({"u_id": u_id})
});




module.exports = router;
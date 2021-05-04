
var router = require('express').Router();


router.use(require('../authentication/tokenMiddleware'));

// /shop/todaysItem
router.get('/todaysItem', (req, res) => {
    res.send({"shop": "Todays shop is ebic."})
});


module.exports = router;
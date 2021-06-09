
var router = require('express').Router();


router.use(require('../authentication/tokenMiddleware'));


const categories = [
    {
        name: "Bar joke",
        points: 40
    }, 
    {
        name: "Dad joke",
        points: 10
    },
    {
        name: "Food joke",
        points: 70
    },
    {
        name: "Computer joke",
        points: 300
    },
    {
        name: "One line joke",
        points: 30
    },
    {
        name: "Political joke",
        points: 120
    },
    {
        name: "School joke",
        points: 40
    },
    {
        name: "Random",
        points: 50
    },
];

router.get('/getCategories', (req, res) => {
    n = 10;
    var shuffled = categories.sort(function(){return .5 - Math.random()});
    var selected = shuffled.slice(0,n);
    res.send({"cat": selected});
});


module.exports = router;

var router = require('express').Router();


router.use(require('../authentication/tokenMiddleware'));


const categories = [
    {
        name: "Racist",
        points: 15
    }, 
    {
        name: "Birthday",
        points: 20
    },
    {
        name: "Yo Mama",
        points: 200
    },
    {
        name: "Yo fat mama 2",
        points: 200
    },
    {
        name: "Yo fat mama 3",
        points: 200
    },
    {
        name: "Yo fat mama 4",
        points: 200
    },
    {
        name: "Yo fat mama 5",
        points: 200
    },
    {
        name: "Yo fat mama 6",
        points: 200
    },
];

router.get('/getCategories', (req, res) => {
    n = 10;
    var shuffled = categories.sort(function(){return .5 - Math.random()});
    var selected = shuffled.slice(0,n);
    res.send({"cat": selected});
});


module.exports = router;
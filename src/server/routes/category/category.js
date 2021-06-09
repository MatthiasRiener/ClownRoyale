
var router = require('express').Router();


router.use(require('../authentication/tokenMiddleware'));


router.get('/getCategories', (req, res) => {
    n = 10;
    var shuffled = categories.sort(function(){return .5 - Math.random()});
    var selected = shuffled.slice(0,n);
    res.send({"cat": selected});
});



const categories = [
    {

        id: 1,
        name: "Bar joke",
        points: 40
    }, 
    {
        id: 2,
        name: "Dad joke",
        points: 10
    },
    {
        id: 3,
        name: "Food joke",
        points: 70
    },
    {
        id: 4,
        name: "Computer joke",
        points: 300
    },
    {
        id: 5,
        name: "One line joke",
        points: 30
    },
    {
        id: 6,
        name: "Political joke",
        points: 120
    },
    {
        id: 7,
        name: "School joke",
        points: 40
    },
    {
        id: 8,
        name: "Random",
        points: 50
    },
];

function findCategoryByIndex(index) {
    return categories.find((el) => el.id == index);
}

module.exports = router;
module.exports.findCategoryByIndex = findCategoryByIndex;


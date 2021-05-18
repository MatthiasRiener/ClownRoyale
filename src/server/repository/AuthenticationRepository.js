var db = require('../db/dbConfig');

function createUser() {
    console.log("Creating user...");
    console.log(db);
}

module.exports.createUser = this.createUser;
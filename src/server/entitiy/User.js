const mongoose = require('mongoose');

const { Schema } = mongoose;


module.exports.userShema = new Schema({
    name: String,
    mail: String,
    image: String,
    last_login: Number
});
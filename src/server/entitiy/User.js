const mongoose = require('mongoose');

const { Schema } = mongoose;


module.exports.userShema = new Schema({
    u_id: String,
    name: String,
    mail: String,
    image: String,
    last_login: Number
});
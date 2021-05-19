var db = require('../db/dbConfig');

const UserModel = db.db.model('user', require('../entitiy/User').userShema);
var getInfoFromToken = require('../helper/helper').getInfoFromToken;

function createUser(access_token) {
    const data = getInfoFromToken(access_token);

    checkIfUserExists(data.sub).then(c => {
        if (c > 0) {
            UserModel.updateOne({ u_id: data.sub }, { $set: { last_login: new Date().getTime() } });
        } else {
            UserModel.create({
                u_id: data.sub,
                name: data.preferred_username,
                mail: data.email,
                image: "https://www.einfachbacken.de/sites/einfachbacken.de/files/styles/full_width_tablet_4_3/public/2021-04/bananenbrot.jpg?h=7d326bee&itok=xchvD_0f",
                last_login: new Date().getTime()
            });
        }
    });
}

function checkIfUserExists(u_id) {
    return UserModel.count({ u_id: u_id }, function (err, count) {
        console.log(u_id, count);
    });

}

function checkIfUserExists(u_id) {
    return UserModel.count({ u_id: u_id });
}

async function getUsersFromArray(users) {
    return await users.map((user) => getUser(user));
}


async function getUser(u_id) {
    const doc = await UserModel.findOne({ u_id: u_id }).exec();
    return doc;
}

module.exports.createUser = createUser;
module.exports.getUsersFromArray = getUsersFromArray;
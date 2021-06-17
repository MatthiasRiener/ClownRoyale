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
    return UserModel.count({ u_id: u_id });
}

async function getUsersFromArray(users) {
    var response = [];

    await asyncForEach(users, async (u) => {
        var docu = await getUser(u.u_id);
        docu["isReady"] = u.ready;
        response.push(docu);
    });

    console.log("RETURINING USERS")
    return response;
}

async function getVotedFromUsers(users) {
    var response = [];

    await asyncForEach(users, async (u) => {
        var docu = await getUser(u.u_id);
        docu["hasVoted"] = u.hasVoted;
        response.push(docu);
    });

    console.log("RETURINING USERS")
    return response;
}

async function getPointsFromUsers(users) {
    var response = [];

    await asyncForEach(users, async (u) => {
        var docu = await getUser(u.u_id);
        docu["points"] = u.points;
        response.push(docu);
    });

    response.sort((a, b) => b.points - a.points);
    return response;
}

async function asyncForEach(array, callback) {
    for (let index = 0; index < array.length; index++) {
        await callback(array[index], index, array);
    }
}


function getUser(u_id) {
    return UserModel.findOne({ u_id: u_id }).lean().exec();
}

module.exports.createUser = createUser;
module.exports.getUsersFromArray = getUsersFromArray;
module.exports.getVotedFromUsers = getVotedFromUsers;
module.exports.getPointsFromUsers = getPointsFromUsers;
module.exports.getUser = getUser;
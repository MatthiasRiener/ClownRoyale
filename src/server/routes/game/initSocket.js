let io, connectedDevices = [],
    socket;

function initializeSocket(server) {
    io = require('socket.io')(server);



    io.on('connection', (socket) => {

        var isConnected = false;
        connectedDevices.forEach((user) => {
            if (user.sid == socket.id) {
                isConnected = true;
            }
        });

        if (!isConnected) {
            connectedDevices.push({
                sid: socket.id,
                uid: undefined
            });
        }

        socket = socket;
        intializeEvents(socket);

        socket.on("disconnect", (reason) => {
            // ...
            console.log("disconnect....")
            console.log(socket.id);
            disconnectUserFromLobby(socket.id);
        });

    });
}

function disconnectUserFromLobby(session) {
    var u_idToRemove = "";
    var lobbyID = "";


    var devicesCount = 0;
    connectedDevices.forEach((el) => {
        if (el.sid == session) {
            u_idToRemove = el.uid;
            connectedDevices.splice(devicesCount, 1);
        }

        devicesCount++;
    });

    console.log(u_idToRemove);
    console.log(connectedDevices);

    ONGOING_LOBBIES.some((lobby) => {
        var userIndex = 0;
        lobby.users.forEach((el) => {

            if (el.u_id == u_idToRemove) {
                console.log("SOUTS")
                console.log(lobby.id);
                lobbyID = lobby.id;
                lobby.users.splice(userIndex, 1);
            }
            userIndex++;
        });
    })

    console.log(devicesCount);
    console.log("SHOULD HAVE CLEANED THE SHIT");
    console.log(ONGOING_LOBBIES);


    ONGOING_LOBBIES.some((lobby) => {
        if (lobby.id == lobbyID) {
            getUsersFromArray(lobby.users).then((users) => {
                emitToRoom("joinLobbyResponse", {
                    "status": 1,
                    "lobbyID": lobby.id,
                    "type": "readyPressed",
                    "users": users
                }, lobby.users);
            });
        }
    });



}

function intializeEvents(socket) {
    socket.on('joinLobbyRequest', (data) => {
        var u_id = data.u_id;

        // update u_id in connected devices
        connectedDevices.forEach((user) => {
            if (user.sid == socket.id) {
                user.uid = u_id;
            }
        });



        joinLobby(u_id, socket);

    });


    socket.on('userIsReady', (data) => {
        var u_id = data.userID;
        var roomID = data.roomID;
        console.log("DES IS A LOG");
        console.log(u_id, roomID);
        setUserToReady(roomID, u_id);
        // send to user_is ready response
    });

    socket.on('userVoted', (data) => {
        var u_id = data.userID;
        var roomID = data.roomID;
        var points = data.points;

        ONGOING_LOBBIES.some((lobby) => {
            if (lobby.id == roomID) {
                lobby.users.forEach((u) => {
                    if (u.isTeller) {
                        lobby.users.forEach((u_2) => {
                            if (u_2.u_id == u_id && !u_2.hasVoted) {
                                u.points += points;
                                u_2.hasVoted = true;
                                getVotedFromUsers(lobby.users).then((users) => {
                                    emitToRoom("userHasVotedEveryoneIsHappyLetsGo", {
                                        "status": 1,
                                        "voter": u_2,
                                        "type": "voted",
                                        "users": users
                                    }, lobby.users);
                                    //emitToUser("joinLobbyResponse", u_id, { "status": 1, "type": "foundLobby", "users": users }, socket);
                                    CheckFinishRoundAndStartNew(false, lobby.id);
                                })

                            } else {
                                console.log("net mehrmals voten du nig");
                            }
                        });

                    }
                });

                console.log("POINTS WERE UPDTED LOL");
                console.log(lobby);
            }
        });

    });

    socket.on('userChoseCategory', (data) => {
        var u_id = data.userID;
        var lobbyID = data.roomID;
        var categoryID = parseInt(data.catID);

        console.log("WHAT THE FUCK HEHEHEHEHEHEHEHEH (Muchael JAckson");
        console.log(u_id, lobbyID, categoryID);


        console.log("FETCHING CLICKED CATEGORY CXD");
        var category = require('../category/category').findCategoryByIndex(categoryID);
        console.log("RECEIVED CATEGORY");
        console.log(category);

        ONGOING_LOBBIES.some((lobby) => {
            if (lobby.id == lobbyID) {
                getVotedFromUsers(lobby.users).then((users) => {

                    console.log("USERS", lobby.users);

                    var curTeller;
                    lobby.users.forEach((user) => {
                        if (user.isTeller) {
                            curTeller = user;
                        }
                    });

                    console.log("CURREEELLTTELLER")
                    console.log(curTeller)

                    emitToRoom("userDecidedToClickOnCategoryThanksEveryone", {
                        "status": 1,
                        "lobbyID": lobby.id,
                        "type": "categoryChosen",
                        "users": users,
                        "category": category,
                        "teller": curTeller
                    }, lobby.users);
                });
            }
        });



    });
}


getPointsFromUsers = require('../../repository/AuthenticationRepository').getPointsFromUsers;

function CheckFinishRoundAndStartNew(wasClicked, lobbyID) {
    var everyoneVoted = true;

    ONGOING_LOBBIES.forEach((lobby) => {
        if (lobby.id == lobbyID) {

            lobby.users.forEach((user) => {
                if (!user.hasVoted && !user.isTeller) {
                    everyoneVoted = false;
                }
            });

            if (wasClicked || everyoneVoted) {
                // reset hasVoted of each user

                lobby.users.forEach((us) => {

                    if (us.isTeller) {
                        us.wasTeller = true;
                        us.isTeller = false;
                    }

                    us.hasVoted = false;
                })


                // check if game is finished

                var gameFinished = true;


                lobby.users.forEach((usr) => {
                    if (!usr.wasTeller) {
                        gameFinished = false;
                    }
                });

                if (gameFinished) {
                    console.log("JEDER WAR BEREITS DRAN!");
                    getPointsFromUsers(lobby.users).then((users) => {

                        emitToRoom("gameFinishedNotification", {
                            "status": 1,
                            "lobbyID": lobby.id,
                            "users": users
                        }, lobby.users)

                        // lobby entfernen
                        var lobbyIndex = 0;
                        ONGOING_LOBBIES.some((curlob) => {
                            if (lobby.id = curlob.id) {
                                ONGOING_LOBBIES.splice(lobbyIndex, 1);
                                console.log("REMOVED FINISHED LOBBY!");
                                console.log(ONGOING_LOBBIES);
                            }
                            lobbyIndex++;
                        });

                        // ende muss noch ausgecoded werden

                        console.log("Guten Tag. Ich bin das ausgecodete Ende.");
                        updatePointsToAllTimeUsers(users);


                    });
                    return;
                }

                // choose next user and start new round
                console.log("JEDER HAT GEVOTED, NEUE RUNDE LOL!")
                var index = getIndexOfNextPlayer(lobby.users);
                lobby.users[index].isTeller = true;
                console.log(lobby.users);
                emitToRoom("lobbyReadyToStartResponse", {
                    "status": 1,
                    "lobbyID": lobby.id,
                    "type": "readyPressed",
                    "teller": lobby.users[index]
                }, lobby.users);




            }
        }
    });
}

function setUserToReady(lobbdyID, u_id) {
    ONGOING_LOBBIES.some((lobby) => {
        if (lobby.id == lobbdyID) {
            lobby.users.some((user) => {
                if (user.u_id == u_id) {
                    user.ready = true;

                    checkIfEveroneIsReady(lobby);

                    getUsersFromArray(lobby.users).then((users) => {
                        console.log("CHANING STATUS OF USER");
                        console.log(users);
                        emitToRoom("changeStatusOfPlayer", {
                            "status": 1,
                            "lobbyID": lobby.id,
                            "type": "readyPressed",
                            "users": users
                        }, lobby.users);

                        //emitToUser("joinLobbyResponse", u_id, { "status": 1, "type": "foundLobby", "users": users }, socket);
                    })
                }
            });
        }
    });
}

function checkIfEveroneIsReady(lobby) {
    var lobbyReady = true;

    console.log("checking for lobby....", lobby);

    lobby.users.forEach((user) => {
        console.log("checking user", user);
        if (!user.ready) {
            lobbyReady = false;
        }
    });


    if (lobbyReady) {
        lobby.status = 'READY';

        console.log("SERVER IS STARTING");
        var index = getIndexOfNextPlayer(lobby.users);

        getUsersFromArray([lobby.users[index]]).then((users) => {
            lobby.users[index].wasTeller = true;
            lobby.users.forEach((u) => {
                u.isTeller = false;
                u.hasVoted = false;
            });
            lobby.users[index].isTeller = true;

            emitToRoom("lobbyReadyToStartResponse", {
                "status": 1,
                "lobbyID": lobby.id,
                "type": "readyPressed",
                "teller": users[index]
            }, lobby.users);
        });

    }
}

function getIndexOfNextPlayer(players) {
    var index = 0;
    var nextIndex = undefined;

    players.forEach((player) => {
        if (!player.wasTeller && nextIndex == undefined) {
            nextIndex = index;
        }
        index++;
    });

    return nextIndex;
}

const MAX_SIZE = 8;
const ONGOING_LOBBIES = [];

// LOBBY STATUS
// WAITING => Waiting for Fillup
// READY => Ready

getUsersFromArray = require('../../repository/AuthenticationRepository').getUsersFromArray;
getVotedFromUsers = require('../../repository/AuthenticationRepository').getVotedFromUsers;



function joinLobby(u_id, socket) {
    if (lobbyAvailable(u_id)) {
        ONGOING_LOBBIES.some((lobby) => {
            if (lobby.status == 'WAITING') {
                lobby.users.push({
                    "u_id": u_id,
                    "ready": false,
                    "wasTeller": false,
                    "isTeller": false,
                    "points": 0
                });

                if (lobby.users.length == MAX_SIZE) {
                    lobby.status = 'READY';
                }

                getUsersFromArray(lobby.users).then((users) => {


                    emitToRoom("newUserHasJoined", {
                        "status": 1,
                        "lobbyID": lobby.id,
                        "type": "foundLobby",
                        "users": users,
                        "new_user": u_id
                    }, lobby.users);
                    emitToUser("successJoin", u_id, {
                        "status": 1,
                        "type": "successJoin",
                        "lobbyID": lobby.id,
                        "type": "foundLobby",
                        "users": users,
                        "new_user": u_id
                    });

                    //emitToUser("joinLobbyResponse", u_id, { "status": 1, "type": "foundLobby", "users": users }, socket);
                })




                return lobby;
            }
        });
    } else {
        var newLobby = createNewLobby(u_id);

        getUsersFromArray(newLobby.users).then((users) => {
            emitToUser("successJoin", u_id, {
                "status": 1,
                "type": "successJoin",
                "lobbyID": newLobby.id,
                "type": "foundLobby",
                "users": users,
                "new_user": u_id
            });
            //emitToUser("joinLobbyResponse", u_id, { "status": 1, "type": "createdLobby", "users": users }, socket);
        })

    }
}

function lobbyAvailable(u_id) {
    /*
        muss noch überarbeitet werden, momentan okey
    */
    isAvailable = false;

    ONGOING_LOBBIES.some((lobby) => {
        if (lobby.users.length < MAX_SIZE) {
            isAvailable = true;
        }
    });

    return isAvailable;
}

var uuidv4 = require('uuid').v4;

function createNewLobby(creator) {
    const lobby = {
        id: uuidv4(),
        status: 'WAITING',
        users: [{
            "u_id": creator,
            "ready": false,
            "wasTeller": false,
            "isTeller": false,
            "points": 0
        }],
        creator: creator,
        created: new Date().getTime()
    };

    ONGOING_LOBBIES.push(lobby);

    return lobby;
}


function emitToUser(event, uid, msg, socket) {
    console.log("EMITTING TO USERR")
    console.log(event);
    console.log(uid);


    connectedDevices.some((user) => {
        console.log("DEVICE", user)
        if (user.uid == uid) {
            console.log("SEVRUZS");

            Object.keys(io.sockets.sockets).forEach((socketid) => {
                if (socketid == user.sid) {
                    console.log("SERVUS 2");
                    console.log(socketid)
                    io.to(socketid).emit(event, msg);
                }
            });
        }
    });
}

function emitToRoom(event, msg, users) {
    users.forEach((user) => {
        connectedDevices.some((user_device) => {
            if (user.u_id == user_device.uid) {

                Object.keys(io.sockets.sockets).forEach((socketid) => {
                    if (socketid == user_device.sid) {
                        io.to(socketid).emit(event, msg);
                    }
                });
            }
        });
    });

}


function getRoomOfUser(u_id) {
    lobbyID = ""
    hasFound = false;

    ONGOING_LOBBIES.forEach((lobby) => {
        lobby.users.forEach((user) => {
            if (user.u_id == u_id && !hasFound) {
                lobbyID = lobby.id;
                hasFound = true;
                return lobbyID;
            }
        });
    });

    return lobbyID;
}

var updateUserPoints = require('../../repository/AuthenticationRepository').updateUserPoints;

async function updatePointsToAllTimeUsers(users) {
    console.log("GAME FINISHED");
    console.log(users);

    users.forEach((u) => {
        var updatedUser = updateUserPoints(u);
        console.log("User was updated!")
        console.log(updatedUser);
    })
}

module.exports.initializeSocket = initializeSocket;
module.exports.getRoomOfUser = getRoomOfUser;
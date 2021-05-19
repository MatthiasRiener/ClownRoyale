let io, connectedDevices = [], socket;

function initializeSocket(server) {
    console.log("iniitalizing socket...")
    io = require('socket.io')(server);



    io.on('connection', (socket) => {
        console.log("a user connected...");

        var isConnected = false;
        connectedDevices.forEach((user) => {
            if (user.sid == socket.id) {
                isConnected = true;
            }
        });

        if (!isConnected) {
            connectedDevices.push({ sid: socket.id, uid: undefined });
        }

        socket = socket;
        intializeEvents(socket);

    });
}

function intializeEvents(socket) {
    socket.on('joinLobbyRequest', (data) => {
        var u_id = data.u_id;

        // update u_id in connected devices
        connectedDevices.forEach((user) => {
            if (user.sid == socket.id) {
                user.uid = u_id;
                console.log("UPDATED USER ENTRY");
            }
        });


        console.log("====")

        joinLobby(u_id, socket);

    });
}


const MAX_SIZE = 8;
const ONGOING_LOBBIES = [];

// LOBBY STATUS
// WAITING => Waiting for Fillup
// READY => Ready

getUsersFromArray = require('../../repository/AuthenticationRepository').getUsersFromArray;

function joinLobby(u_id, socket) {
    if (lobbyAvailable(u_id)) {
        ONGOING_LOBBIES.some((lobby) => {
            if (lobby.status == 'WAITING' && !lobby.users.includes(u_id)) {
                lobby.users.push(u_id);

                if (lobby.users.length == MAX_SIZE) {
                    lobby.status = 'READY';
                }

                getUsersFromArray(lobby.users).then((users) => {
                    emitToRoom("joinLobbyResponse", { "status": 1, "type": "foundLobby", "users": users }, lobby.users);

                    //emitToUser("joinLobbyResponse", u_id, { "status": 1, "type": "foundLobby", "users": users }, socket);
                })


                return lobby;
            }
        });
    } else {
        var newLobby = createNewLobby(u_id);
        console.log(newLobby.users)

        getUsersFromArray(newLobby.users).then((users) => {
            emitToRoom("joinLobbyResponse", { "status": 1, "type": "createdLobby", "users": users }, newLobby.users);
            //emitToUser("joinLobbyResponse", u_id, { "status": 1, "type": "createdLobby", "users": users }, socket);
        })

    }
}

function lobbyAvailable(u_id) {
    let isAvailable = false;

    ONGOING_LOBBIES.forEach((lobby) => {
        if (lobby.status == 'WAITING' && !lobby.users.includes(u_id)) {
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
        users: [creator],
        creator: creator,
        created: new Date().getTime()
    };


    ONGOING_LOBBIES.push(lobby);

    return lobby;
}


function emitToUser(event, uid, msg, socket) {
    connectedDevices.some((user) => {
        if (user.uid == uid) {

            Object.keys(io.sockets.sockets).forEach((socketid) => {
                if (socketid == user.sid) {
                    io.to(socketid).emit(event, msg);
                }
            });
        }
    });
}

function emitToRoom(event, msg, users) {
    users.forEach((user) => {
        connectedDevices.some((user_device) => {
            if (user.uid == user_device.uid) {

                Object.keys(io.sockets.sockets).forEach((socketid) => {
                    if (socketid == user_device.sid) {
                        io.to(socketid).emit(event, msg);
                    }
                });
            }
        });
    });

}



module.exports.initializeSocket = initializeSocket;


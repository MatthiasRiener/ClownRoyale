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
            connectedDevices.push({sid: socket.id, uid: undefined});
        }
        
        socket = socket;
        intializeEvents(socket);
        
    });
}

function intializeEvents(socket) {
    socket.on('joinLobbyRequest', (data) => {
        var u_id = data.u_id;

        // update u_id in connected devices

        console.log(data);
        console.log(socket);

        console.log("======")


        joinLobby(u_id);

    });
}


const MAX_SIZE = 8;
const ONGOING_LOBBIES = [];

// LOBBY STATUS
// WAITING => Waiting for Fillup
// READY => Ready
function joinLobby(u_id) {
    if (lobbyAvailable()) {
        ONGOING_LOBBIES.some((lobby) => {
            if (lobby.status == 'WAITING') {
                lobby.users.push(u_id);

                if (lobby.users.length == MAX_SIZE) {
                    lobby.status = 'READY';
                }

                emitToUser("joinLobbyResponse", u_id, {"status": 1, "type": "foundLobby", "users": lobby.users});

                return lobby;
            }
        });
    } else {
        var newLobby = createNewLobby(u_id);
        emitToUser("joinLobbyResponse", u_id, {"status": 1, "type": "createdLobby", "users": newLobby.users});

    }
}

function lobbyAvailable() {
    let isAvailable = false;

    ONGOING_LOBBIES.forEach((lobby) => {
        if (lobby.status == 'WAITING') {
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


function emitToUser(event, uid, msg) {
    console.log("EMITIING TOO USEERR");
    console.log(event, uid, msg);
    console.log(connectedDevices);

    connectedDevices.some((user) => {
        if (user.uid == uid) {
            socket.broadcast.to(socketid).emit(event, msg);
        }
    });
}


module.exports.initializeSocket = initializeSocket;


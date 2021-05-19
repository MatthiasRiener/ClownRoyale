let io, connectedDevices;

function initializeSocket(server) {
    console.log("iniitalizing socket...")
    io = require('socket.io')(server);

    connectedDevices = [];
    
    
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
    
        intializeEvents(socket);
        
    });
}

function intializeEvents(socket) {
    socket.on('joinLobbyRequest', (data) => {
        var u_id = data.u_id;
        console.log("Requesting to join lobby...", u_id);
        console.log("added you to the lobby")

        // simulating that joining was successful
        io.emit("joinLobbyResponse", {"status": 1});
    });
}

module.exports.initializeSocket = initializeSocket;


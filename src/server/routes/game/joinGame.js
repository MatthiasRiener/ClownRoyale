const Server = require('socket.io').Server;
const app = require('../../index').app;
const io = new Server(app, {origins: "http://localhost"});

io.on('connection', (socket) => {
    console.log("a user connected...");
});







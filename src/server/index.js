const express = require('express');

const app = express();

app.use(express.json())
app.use(express.urlencoded({extended: true}))

const port = 5000;

const server = require('http').createServer(app);



const io = require('socket.io')(server);



io.on('connection', (socket) => {
    console.log("a user connected...");
});



app.get('/', (req, res) => {
    res.send('Hallo 4CHIF!');
});



app.use('/auth', require('./routes/authentication/auth'));
app.use('/video', require('./routes/videochat/videochat'));
app.use('/shop', require('./routes/shop/shop'));
app.use('/user', require('./routes/user/user'));



server.listen(port, () => {
    console.log(`Das Herzstück des Projektes wurde soeben auf Port ${port} gestartet. `);
})


module.exports.app = app;

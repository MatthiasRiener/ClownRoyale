const express = require('express');

const app = express();

app.use(express.json())
app.use(express.urlencoded({extended: true}))

const port = 5000;

const server = require('http').createServer(app);


require('./routes/game/initSocket').initializeSocket(server);


app.get('/', (req, res) => {
    res.send('Hallo 4CHIF!');
});



app.use('/auth', require('./routes/authentication/auth'));
app.use('/video', require('./routes/videochat/videochat'));
app.use('/shop', require('./routes/shop/shop'));
app.use('/category', require('./routes/category/category'));
app.use('/user', require('./routes/user/user'));



server.listen(port, () => {
    console.log(`Das Herzstück des Projektes wurde soeben auf Port ${port} gestartet. `);
})


module.exports.app = app;
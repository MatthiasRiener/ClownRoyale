const express = require('express');
const bodyParser = require('body-parser');

const app = express();

app.use(express.json())
app.use(express.urlencoded({extended: true}))

const port = 5000;



app.get('/', (req, res) => {
    res.send('Hallo 4CHIF!');
});



app.use('/auth', require('./routes/authentication/auth'));
app.use('/video', require('./routes/videochat/videochat'));



app.listen(port, () => {
    console.log(`Das Herzstück des Projektes wurde soeben auf Port ${port} gestartet. `);
})


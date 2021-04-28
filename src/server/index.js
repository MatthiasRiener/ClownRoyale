const express = require('express');
const app = express();
const port = 5000;

app.get('/', (req, res) => {
    res.send('Hallo 4CHIF!');
});

app.listen(port, () => {
    console.log(`Das Herzstück des Projektes wurde soeben auf Port ${port} gestartet. `);
})

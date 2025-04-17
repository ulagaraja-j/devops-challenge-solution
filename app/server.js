const express = require('express');
const app = express();
const port = 5000;

app.set('trust proxy', true);

app.get('/', (req, res) => {
    const timestamp = new Date().toISOString(); // Shows the UTC time by default
    const ip = req.ip;
    res.json({
        timestamp,
        ip
    });
});

app.listen(port, '0.0.0.0', () => {
    console.log('Server running on port 5000');
});


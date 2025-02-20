const express = require('express');
const app = express();
const fs = require('fs');
const path = require('path');

app.get('/:filename', (req, res) => {
    let filename = req.params.filename;

    if (path.extname(filename) !== '.lua') {
        filename += '.lua';
    }

    const filePath = path.join(__dirname, 'lua', filename);

    fs.access(filePath, fs.constants.R_OK, (err) => {
        if (err) {
            return res.status(404).send('File not found');
        }
        res.sendFile(filePath);
    });
});

app.listen(9292, () => {
    console.log('Server running on port 3000');
});

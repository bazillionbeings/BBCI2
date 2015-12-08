'use strict';

let app = require('express')(),
    shell = require('shelljs');

app.post('/', (req, res) => {
    shell.exec('./pull.sh ~/BBCentralizedDB');
    res.end();
});

app.listen(4333);

'use strict';

let http = require('http'),
    childProcess = require('child_process');

const PORT=4333;

function handleRequest(request, response){
    childProcess.exec(__dirname + './pull.sh ~/BBCentralizedDB');
    res.end();
}

let server = http.createServer(handleRequest);

server.listen(PORT);
'use strict';

let http = require('http'),
    childProcess = require('child_process');

const PORT = 4333;

function handleRequest(request, res) {
    console.log('pull request');
    childProcess.exec(__dirname + '/pull.sh ~/BBCentralizedDB', function(err, stdout, stderr) {
        if (err) console.error(err);
        if (stderr) console.error(stderr);
        if (stdout) console.log(stdout);
    });
    res.end();
}

let server = http.createServer(handleRequest);

//server.listen(PORT);

childProcess.exec(__dirname + '/pull.sh ~/BBCentralizedDB', function(err, stdout, stderr) {
    console.error(stderr);
    console.log(stdout);
});
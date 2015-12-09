'use strict';

let http = require('http'),
    spawn = require('child_process').spawn;

const PORT = 4333;

function handleRequest(request, res) {
    /*console.log('pull request');
    childProcess.execFile(__dirname + '/pull.sh ~/BBCentralizedDB', function(err, stdout, stderr) {
        console.error(stderr);
        console.log(stdout);
    });
    res.end();*/

    let command = spawn(__dirname + '/pull.sh ~/BBCentralizedDB');
    //let output  = [];

    command.stdout.on('data', function(chunk) {
        //output.push(chunk);
        console.log(chunk);
    });

    command.on('close', function(code) {
        if (code === 0) {
            //res.send(Buffer.concat(output));
        }
        else {
            console.log('failed');
            //res.send(500); // when the script fails, generate a Server Error HTTP response
        }
    });
}

let server = http.createServer(handleRequest);

server.listen(PORT);
'use strict';

require('shelljs/global');

let http = require('http'),
    childProcess = require('child_process');

const PORT = 4333;

function handleRequest(request, res) {
    console.log('pull request');
    childProcess.exec(__dirname + '/pull.sh ~/BBCentralizedDB', function(err, stdout, stderr) {
        if (err) {
            console.log('err');
            console.error(err);
        }
        if (stderr) {
            console.log('stderr');
            console.error(stderr);
        }
        if (stdout) console.log(stdout);
    });
    res.end();
}

let server = http.createServer(handleRequest);

//server.listen(PORT);

// childProcess.exec(__dirname + '/pull.sh ~/BBCentralizedDB', function(err, stdout, stderr) {
//     if (err) {
//         console.log('err');
//         console.error(err);
//     }
//     if (stderr) {
//         console.log('stderr');
//         console.error(stderr);
//     }
//     if (stdout) {
//         console.log('stdout');
//         console.log(stdout);
//     }
// });

// childProcess.execFile('./pull.sh', ['/home/ubuntu/BBCentralizedDB'], {
// }, function(err, stdout, stderr) {
//     if (err) {
//         console.log('err');
//         console.error(err);
//     }
//     if (stderr) {
//         console.log('stderr');
//         console.error(stderr);
//     }
//     if (stdout) {
//         console.log('stdout');
//         console.log(stdout);
//     }
// });

exec(__dirname + '/pull.sh /home/ubuntu/BBCentralizedDB', function(code, output) {
  console.log('Exit code:', code);
  console.log('Program output:', output);
});

process.on('uncaughtException', function(err) {
    console.log('Caught exception: ' + err);
});

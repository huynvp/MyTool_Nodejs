var express = require('express'),
    cors = require('cors'),
    morgan = require('morgan'),
    body_parser = require('body-parser'),
    config = require('config'),
    fs = require('fs'),
    router = require('./router/router'),
    multer = require('multer');
    // upload = multer({ dest: 'public/uploads/' });

var http = require('http').Server(express);
var io = require('socket.io')(http);

// var storage = multer.diskStorage({
//     destination: function (req, file, cb) {
//         cb(null, './public/uploads/')
//     },
//     filename: function (req, file, cb) {
//         cb(null, `Import_${Date.now()}.xlsx`)
//     }
// })
    
// var upload = multer({ storage: storage })

var app = express();
var server_config = config.get('ServerConfig');
var socket_config = config.get('SocketConfig');

var accessLogStream = fs.createWriteStream(__dirname + '/access.log', { flags: 'a' })

app.use(cors());
app.use(morgan('common',{ stream: accessLogStream }));

app.use(body_parser.json());

app.use('/', express.static(__dirname + "/public"));

// app.get('/api/test', (req, res) => {

//     res.json('123');
// });

// app.post('/upload', upload.single('excel_file'), (req, res, next) => {
//     console.log(req.file.filename);
//     var data = fs.readFileSync(`./public/uploads/${req.file.filename}`);
//     var excel = xlsx.read(data, {type:'buffer'});

    
//     res.json(excel)
// })

app.use('/api', router);

let user_online = [];
io.on('connection', (socket) => {
    console.log(`Co nguoi ket noi ${socket.id}...`);
    io.on("connection", function(socket) {
        // socket.on("login", function(userdata) {
        //     socket.handshake.session.userdata = userdata;
        //     socket.handshake.session.save();
        // });
        // socket.on("logout", function(userdata) {
        //     if (socket.handshake.session.userdata) {
        //         delete socket.handshake.session.userdata;
        //         socket.handshake.session.save();
        //     }
        // });

        socket.on('send-register-user', (data) => {
            socket.user_name = data;
            user_online.push(data);
            io.sockets.emit('list-user-online', user_online);
        })

        socket.on('close', () => {
            console.log('Close connection');
        })

        socket.on("disconnect", function(userdata) {
            user_online.splice(user_online.indexOf(socket.user_name));
            console.log(user_online);
            console.log('Co nguoi ngat ket noi ' + socket.user_name);
            socket.user_name = '';
            io.sockets.emit('list-user-online', user_online);
        });
    });
})

app.listen(server_config.port, () => {
    console.log(`Server is started port ${server_config.port}`)
})

http.listen(socket_config.port, () => {
    console.log(`Socket server is started port ${socket_config.port}`)
})
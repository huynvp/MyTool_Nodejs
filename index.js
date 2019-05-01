var express = require('express'),
    cors = require('cors'),
    morgan = require('morgan'),
    body_parser = require('body-parser'),
    config = require('config'),
    fs = require('fs'),
    router = require('./router/router');

var app = express();
var server_config = config.get('ServerConfig');
var socket_config = config.get('SocketConfig');

var accessLogStream = fs.createWriteStream(__dirname + '/access.log', { flags: 'a' })

app.use(cors());
app.use(morgan('common',{ stream: accessLogStream }));

app.use(body_parser.json());

app.use('/', express.static(__dirname + "/public"));

// app.post('/upload', upload.single('excel_file'), (req, res, next) => {
//     console.log(req.file.filename);
//     var data = fs.readFileSync(`./public/uploads/${req.file.filename}`);
//     var excel = xlsx.read(data, {type:'buffer'});

    
//     res.json(excel)
// })

app.use('/api', router);

app.listen(server_config.port, () => {
    console.log(`Server is started port ${server_config.port}`)
})
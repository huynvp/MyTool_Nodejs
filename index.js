var express = require('express'),
    cors = require('cors'),
    morgan = require('morgan'),
    body_parser = require('body-parser'),
    config = require('config'),
    fs = require('fs'),
    xlsx = require('xlsx'),
    router = require('./router'),
    multer = require('multer');
    // upload = multer({ dest: 'public/uploads/' });


var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './public/uploads/')
    },
    filename: function (req, file, cb) {
        cb(null, `Import_${Date.now()}.xlsx`)
    }
})
    
var upload = multer({ storage: storage })

var app = express();
var server_config = config.get('ServerConfig');

app.use(cors());
app.use(morgan('dev'));
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

app.listen(server_config.port, () => {
    console.log(`Server is started port ${server_config.port}`)
})
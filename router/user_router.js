var express = require('express');
    multer = require('multer');
    upload = multer({ dest: 'public/uploads/' });

var router = express.Router();
var UserController = require('../controller/UserController');

var Middleware = require('../function/middleware');

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './public/image/avatar/')
    },
    filename: function (req, file, cb) {
        req.file_name = Date.now() + file.originalname;
        cb(null, Date.now() + file.originalname)
    }
})
var upload = multer({ storage: storage })

var user_controller = new UserController();
var middleware = new Middleware();

router.post('/login', (req, res) => {
    user_controller.checkLogin(req, res);
})

router.post('/sign-up', (req, res) => {
    user_controller.signup(req, res);
})

router.get('/check-user', middleware.checkToken, (req, res) => {
    user_controller.checkUser(req, res);
})

router.get('/show-user', middleware.checkToken, (req, res) => {
    user_controller.showUser(req, res);
})

router.post('/change-info', middleware.checkToken, (req, res) => {
    user_controller.changeInfo(req, res);
})

router.post('/change-pass', middleware.checkToken, (req, res) => {
    user_controller.changePass(req, res);
})

router.post('/refresh-token', middleware.checkToken, (req, res) => {
    user_controller.refreshToken(req, res);
})

router.post('/update-avatar', upload.single('file'), middleware.checkToken, (req, res) => {
    user_controller.uploadAvatar(req, res);
})
module.exports = router;
var express = require('express');

var router = express.Router();
var UserController = require('../controller/UserController');

var Middleware = require('../function/middleware');

var user_controller = new UserController();
var middleware = new Middleware();

router.post('/login', (req, res) => {
    user_controller.checkLogin(req, res);
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
module.exports = router;
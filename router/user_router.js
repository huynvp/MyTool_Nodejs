var express = require('express');

var router = express.Router();
var UserController = require('../controller/UserController');

var Middleware = require('../function/middleware');

var user_controller = new UserController();
var middleware = new Middleware();

router.post('/login', (req, res) => {
    user_controller.checkLogin(req, res);
})

router.post('/show-user', middleware.checkToken, (req, res) => {
    user_controller.showUser(req, res);
})

module.exports = router;
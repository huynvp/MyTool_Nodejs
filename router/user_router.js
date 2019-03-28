var express = require('express');

var router = express.Router();
var UserController = require('../controller/UserController');

var user_controller = new UserController();



module.exports = router;
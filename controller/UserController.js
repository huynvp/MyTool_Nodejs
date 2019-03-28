var express = require('express');
var BaseController = require('./BaseController');
var router = express.Router();

class UserController extends BaseController {
    constructor() {
        super();
    }

    checkLogin(req, res) {

    }
}

module.exports = UserController;
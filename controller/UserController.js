var express = require('express');
var BaseController = require('./BaseController');
var router = express.Router();
var User = require('../model/user');
var JWT = require('jsonwebtoken');

const config = require('config');
const jwt_config = config.JWT;

class UserController extends BaseController {
    constructor() {
        super();
        this.user = new User();
    }

    checkToken() {
        
    }

    checkLogin(req, res) {
        if(req.body.username == null) {
            res.json('Username is not empty');
        }
        if(req.body.password == null) {
            res.json('Password is not empty');
        }
        this.user.checkLogin(req.body.username, req.body.password)
        .then(rows => {
            if(rows[0].length > 0) {
                var token = JWT.sign({
                    data: {
                        'username': req.body.username
                    }
                }, jwt_config.screet_key, { expiresIn: jwt_config.expires });

                res.status(200);
                res.json(this.responseData({token: token}, 'Đăng nhập thành công', null, 200));
            } else {
                res.status(401);
                res.json(this.responseData(null, 'Đăng nhập thất bại', null, 401));
            }
        })
        .catch(err => {
            res.status(400);
            res.json(err);
        })
    }

    showUser(req, res) {
        this.user.showUser(req.pay_load.username)
        .then(rows => {
            res.status(200);
            res.json(this.responseData(rows[0][0], 'Success', null, 200));
        })
        .catch(err => {
            res.status(400);
            res.json(this.responseData(null, 'User not exists', null, 400));
        });
    }
}

module.exports = UserController;
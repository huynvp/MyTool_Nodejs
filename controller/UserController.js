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

    signup(req, res) {
        let body = req.body;
        this.user.signup(body.name, body.email, body.birthday, body.address, body.phone, body.password)
        .then(data => {
            res.status(200);
            res.json(this.responseData(data, 'Sign up success', null, 200));
        })
        .catch(err => {
            console.log(err);
            res.status(400);
            res.json(this.responseData(err, 'Sign up error', null, 400));
        });
    }

    checkUser(req, res) {
        this.user.showUser(req.pay_load.username)
        .then((data) => {
            res.status(200).json(this.responseData(data[0][0], 'Check ok', null, 200));
        })
        .catch(err => {
            res.status(400).json(this.responseData(null, 'Check ok', null, 200));
        });
    }

    checkLogin(req, res) {
        if(req.body.username == null) {
            res.status(400);
            res.json(this.responseData(null, 'Username is not empty', null, 400));
        }
        if(req.body.password == null) {
            res.status(400);
            res.json(this.responseData(null, 'Password is not empty', null, 400));
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

    changeInfo(req, res) {
        this.user.changeInfo(req.pay_load, req.body)
        .then(rows => {
            res.status(200);
            res.json(this.responseData(null, 'Change info succcess', null, 200));
        })
        .catch(err => {
            console.log(err);
            res.status(400);
            res.json(this.responseData(null, 'Change info faild', null, 400));
        })
    }

    changePass(req, res) {
        this.user.changePass(req.pay_load, req.body)
        .then(rows => {
            res.status(200);
            res.json(this.responseData(null, 'Change pass succcess', null, 200));
        })
        .catch(err => {
            console.log(err);
            res.status(400);
            res.json(this.responseData(null, 'Change pass faild', null, 400));
        })
    }

    refreshToken(req, res) {
        var token = JWT.sign({
            data: {
                'username': req.pay_load.username
            }
        }, jwt_config.screet_key, { expiresIn: jwt_config.expires });

        res.status(200);
        res.json(this.responseData({token: token}, 'Refresh token success', null, 200));
    }

    uploadAvatar(req, res) {
        this.user.updateAvatarPath(req.pay_load.username, req.file_name)
        .then (() => {
            res.status(200).json(this.responseData(req.file_name, 'Success', null, 200))
        })
        .catch((err) => {
            console.log(err);
            res.status(400).json(this.responseData(req.file_name, 'Error', null, 200))
        });
    }
}

module.exports = UserController;
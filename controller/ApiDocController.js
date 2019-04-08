var express = require('express');
var BaseController = require('./BaseController');
var router = express.Router();
var ApiDoc = require('../model/api_doc');

class UserController extends BaseController {
    constructor() {
        super();
        this.api_doc = new ApiDoc();
    }

    showProject(req, res) {
        this.api_doc.showProject()
        .then(data => {
            res.status = 200;
            res.json(this.responseData(data[0], 'Success', null, 200));
        })
        .catch(err => {
            console.log(err);
            res.status = 400;
            res.json(this.responseData(null, 'Show data error', null, 400));
        });
    }

    showDetailProject(req, res) {
        this.api_doc.showDetailProject(req.params['id'])
        .then(data => {
            res.status(200);
            res.json(this.responseData(data[0], 'Success', null, 200));
        })
        .catch(err => {
            console.log(err);
            res.status(400);
            res.json(this.responseData(null, 'Get data error', null, 400));
        })
    }
}

module.exports = UserController;
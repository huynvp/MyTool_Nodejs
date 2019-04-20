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

    addApi(req, res) {
        this.api_doc.addApi(req.body.project_id, req.body.method, req.body.name, req.body.content, req.body.params, req.body.response)
        .then(rows => {
            res.status(200);
            res.json(this.responseData(rows, 'Success', null, 200));
        })
        .catch(err => {
            res.status(400);
            res.json(this.responseData(err, 'Error', null, 400));
        })
    }

    addProject(req, res) {
        this.api_doc.addProject(req.body.name)
        .then(rows => {
            res.status(200);
            res.json(this.responseData(rows, 'Success', null, 200));
        })
        .catch(err => {
            res.status(400);
            res.json(this.responseData(err, 'Error', null, 400));
        })
    }

    showOneApi(req, res) {
        this.api_doc.showOneApi(req.params['id'])
        .then(rows => {
            res.status(200);
            res.json(this.responseData(rows, 'Success', null, 200));
        })
        .catch(err => {
            res.status(400);
            res.json(this.responseData(err, 'Error', null, 400));
        })
    }

    editApi(req, res) {
        this.api_doc.editApi(req.body.api_id, req.body.method, req.body.name, req.body.content, req.body.params, req.body.response)
        .then(rows => {
            res.status(200);
            res.json(this.responseData(rows, 'Success', null, 200));
        })
        .catch(err => {
            res.status(400);
            res.json(this.responseData(err, 'Edit error', null, 400));
        })
    }

    deleteApi(req, res) {
        this.api_doc.deleteApi(req.body.id)
        .then(rows => {
            res.status(200);
            res.json(this.responseData(rows, 'Success', null, 200));
        })
        .catch(err => {
            res.status(400);
            res.json(this.responseData(err, 'Edit error', null, 400));
        });
    }
}

module.exports = UserController;
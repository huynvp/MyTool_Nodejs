var express = require('express');

var router = express.Router();
var ProjectController = require('../controller/ApiDocController');
var Middleware = require('../function/middleware');

var middleware = new Middleware();
var project_controller = new ProjectController();

router.get('/project/:id', middleware.checkToken, (req, res) => {
    project_controller.showDetailProject(req, res);
})

router.get('/project', middleware.checkToken, (req, res) => {
    project_controller.showProject(req, res);
})

router.get('/api/:id', middleware.checkToken, (req, res) => {
    project_controller.showOneApi(req, res);
})

router.post('/api/add', middleware.checkToken, (req, res) => {
    project_controller.addApi(req, res);
})

router.post('/project/add', middleware.checkToken, (req, res) => {
    project_controller.addProject(req, res);
})

router.post('/api/edit', middleware.checkToken, (req, res) => {
    project_controller.editApi(req, res);
})

router.post('/api/delete', middleware.checkToken, (req, res) => {
    project_controller.deleteApi(req, res);
})


module.exports = router;
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



module.exports = router;
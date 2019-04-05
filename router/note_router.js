var express = require('express');

var router = express.Router();
var NoteController = require('../controller/NoteController');

var note_controller = new NoteController();

router.get('/home', (req, res) => {
    note_controller.home(req, res);
})

router.get('/show-all', (req, res) => {
    note_controller.showAll(req, res);
})

router.get('/show-level', (req, res) => {
    note_controller.showLevelList(req, res);
})

router.get('/show/:id', (req, res) => {
    note_controller.showOnce(req, res);
});

router.post('/add', (req, res) => {
    note_controller.add(req, res);
})

router.post('/update', (req, res) => {
    note_controller.edit(req, res);
})

router.post('/delete', (req, res) => {
    note_controller.delete(req, res);
})

module.exports = router;
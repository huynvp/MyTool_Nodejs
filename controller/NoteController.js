var express = require('express');
var Note = require('../model/note');
var BaseController = require('./BaseController');
var router = express.Router();

class NoteController extends BaseController {
    constructor() {
        super();
        this.note = new Note();
    }

    home(req, res) {
        console.log(this.note);
        res.json(this.responseData(null, 'Hello note controller', null, 200));
    }

    showAll(req, res) {
        this.note.showAllNote()
        .then(rows => {
            res.json(this.responseData(rows, 'Success', null, 200));
        })
        .catch(err => {
            res.status(400);
            res.json(this.responseData(null, 'Show all note error', null, 400));
            console.log(err);
        })
    }

    showOnce(req, res) {
        this.note.showOnceNote(req.params['id'])
        .then(data => {
            res.status(200);
            res.json(this.responseData(data, 'Success', null, 200));
        })
        .catch(err => {
            console.log(err);
            res.status(400);
            res.json(this.responseData(null, 'Show note error', null, 400));
        })
    }

    add(req, res) {
        let data = {
            'title': req.body.title,
            'content': req.body.content,
            'date': req.body.date,
            'level': req.body.level
        };
        this.note.addNote(data)
        .then(rows => {
            res.json(rows);
        })
        .catch(err => {
            res.status(400);
            res.json('Add note error');
            console.log(err);
        });
    }

    edit(req, res) {
        let data = {
            'id': req.body.id,
            'title': req.body.title,
            'content': req.body.content,
            'date': req.body.date,
            'level': req.body.level
            // 'status': req.body.status
        }
    
        this.note.editNote(data)
        .then(rows => {
            res.status(200);
            res.json(rows);
        })
        .catch(err => {
            console.log(err);
            res.status(400);
            res.json('Update node error');
        });
    }

    delete(req, res) {
        this.note.deleteNote(req.body.id)
        .then(rows => {
            res.status(200);
            res.json(rows);
        })
        .catch(err => {
            res.status(400);
            res.json('Delete node error');
            console.log(err);
        })
    }

    showLevelList(req, res) {
        this.note.showLevel()
        .then(data => {
            res.status(200);
            res.json(this.responseData(data, 'Success', null, 200));
        })
        .catch(err => {
            console.log(err);
            res.json(this.responseData('Show level errorr', 'Errorr', null, 400));
        });
    }
}

module.exports = NoteController;
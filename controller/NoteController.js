var express = require('express');
var Note = require('../model/note');
var router = express.Router();

class NoteController {
    constructor() {
        this.note = new Note();
    }

    home(req, res) {
        console.log(this.note);
        res.json('Hello note controller');
    }

    showAll(req, res) {
        this.note.showAllNote()
        .then(rows => {
            res.json(rows);
        })
        .catch(err => {
            res.status(400)
            res.json({
                status_code: 400,
                message: 'Show all note error'
            });
            console.log(err);
        })
    }

    showOnce(req, res) {
        this.note.showOnceNote(req.params['id'])
        .then(data => {
            res.status(200);
            res.json(data);
        })
        .catch(err => {
            res.status(400);
            res.json(err);
        })
    }

    add(req, res) {
        let data = {
            'title': req.body.title,
            'content': req.body.content,
            'date': req.body.date
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
}

module.exports = NoteController;
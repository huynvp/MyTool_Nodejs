var express = require('express');
var note = require('../model/note');
var router = express.Router();

router.use('/home', (req, res) => {
    res.json('Hello note controller');
})

router.get('/show-all', (req, res) => {
    note.showAllNote()
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
})

router.post('/add', (req, res) => {
    data = {
        'title': req.body.title,
        'content': req.body.content,
        'date': req.body.date
    };
    note.addNote(data)
    .then(rows => {
        res.json(rows);
    })
    .catch(err => {
        res.status(400);
        res.json('Add note error');
        console.log(err);
    });
})

router.post('/update', (req, res) => {
    data = {
        'id': req.body.id,
        'title': req.body.title,
        'content': req.body.content,
        'date': req.body.date,
        'status': req.body.status
    }

    note.editNote(data)
    .then(rows => {
        res.status(200);
        res.json(rows);
    })
    .catch(err => {
        res.status(400);
        res.json('Update node error');
    });
})

router.delete('/delete', (req, res) => {
    note.deleteNote(req.body.id)
    .then(rows => {
        res.status(200);
        res.json(rows);
    })
    .catch(err => {
        res.status(400);
        res.json('Delete node error');
    })
})

module.exports = router;
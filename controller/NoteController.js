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
        res.json(err);
    })
})

router.post('/add', (req, res) => {
    console.log(req.body)
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
        res.json(err);
    });
})

module.exports = router;
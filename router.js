var express = require('express');
var note = require('./controller/NoteController');
var router = express.Router();

router.get('/', (req, res) => {
    res.json('Test api router');
})

router.use('/note', note);

module.exports = router;
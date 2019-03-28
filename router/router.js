var express = require('express');
var note_router = require('./note_router');
var router = express.Router();

router.get('/', (req, res) => {
    res.json('Test api router');
})

router.use('/note', note_router);

module.exports = router;
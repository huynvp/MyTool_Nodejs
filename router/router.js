var express = require('express');
var router = express.Router();

var note_router = require('./note_router');
var user_router = require('./user_router');
var api_doc_router = require('./api_doc_router');

router.get('/', (req, res) => {
    res.json('Test api router');
})

router.use('/note', note_router);
router.use('/user', user_router);
router.use('/api-doc', api_doc_router);

module.exports = router;
const router = require('express').Router();
const authorController = require('../controller/authorController')

router.post('/save', authorController.saveAuthor);


module.exports = router
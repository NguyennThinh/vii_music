const router = require('express').Router();
const singerController = require('../controller/singerController')

router.post('/save', singerController.saveSinger);


module.exports = router
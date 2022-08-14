const router = require('express').Router();
const songController = require('../controller/songController')

router.post('/save', songController.saveSong);
router.get('/listen', songController.getSongByListen);
router.get('/new-song', songController.getSongByCreate);
router.post('/like', songController.likeSong);
router.post('/dislike', songController.dislikeSong);
router.get('/', songController.getSongs)


module.exports = router
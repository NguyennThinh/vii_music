const router = require('express').Router();
const userController = require('../controller/userController')
const uploadImage = require('../config/firebase')
//const storage = require('../config/firebase')
const multer = require('multer')

var storage = multer.diskStorage({
    destination:(req,file,res)=>{
        res(null, './upload')
    },
    filename:(req, file, res)=>{
        res(null, file.originalname)
    }
})


var upload = multer({storage:storage})




router.post('/sign-up', userController.signup)//[POST] Create user
router.post('/login', userController.login)//[POST] login user
router.post('/update',upload.single("avatar"),uploadImage, userController.update)//[POST] update user
router.post('/listen/save', userController.savelistenSong)//[POST] save  song listening
router.post('/like', userController.likeSong)//[POST] exits song like
router.get('/listen/:id_user', userController.songListen)//[GET] get list song listening
router.get('/like/:id_user', userController.getSongLikebyUser)//[GET] get list song listening





module.exports = router


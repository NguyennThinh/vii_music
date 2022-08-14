const mongoose  =  require('mongoose')

const songSchema   = new mongoose.Schema({
    name:{
        type:String, 
        require:true
    },
    author:{
        type: mongoose.Schema.Types.ObjectId,
        ref:'Author',
        require:true
    },
    singer:{
        type: mongoose.Schema.Types.ObjectId,
        ref:'Singer',
        require:true
    },
    createAt:{
        type: Number,
        default:Date.now(),
 
    },
    timeSong:{
        type: String,
        require:true
    },
    thumbnail:{
        type:String,
    },
    listen:{
        type:Number,
        default:0
    },
    download:{
        type:Number,
        default:0
    },
    urlSong:{
        type:String,
        require:true
    },
    like:{
        type:Number,
        default:0
    }
})

let Song = mongoose.model('Song', songSchema);

module.exports = Song;


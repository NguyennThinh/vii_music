const mongoose  =  require('mongoose')

const singerSchema = new mongoose.Schema({
    name:{
        type:String,
        require:true
    },
    year:{
        type:Number
    },
    avatar:{
        type:String,
    },
    songs:[{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Song'
    }]
})

let Singer = mongoose.model('Singer', singerSchema);

module.exports = Singer;
const mongoose  =  require('mongoose')

const authorSchema = new mongoose.Schema({
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

let Author = mongoose.model('Author', authorSchema);

module.exports = Author;
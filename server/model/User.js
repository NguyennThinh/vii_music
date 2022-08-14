const mongoose  =  require('mongoose')
require('dotenv').config()


const userSchema = new mongoose.Schema({
    name:{
        type:String,
       
    },
    email:{
        type:String,
        require: true,
        unique:true
    },
    password:{
        type:String,
        require:true
    },
    avatar:{
        type:String,
        default:process.env.DEFAULT_AVATAR
    },
    createAt:{
        type:String,
        required:true
    },

    updateAt:{
        type:String,
        required:true
    },
    isAdmin:{
        type:Boolean,
        required:true
    },
    tokenSession:{
        type:String,
    },
    likeSong:[
        {
            type: mongoose.Schema.Types.ObjectId,
            ref:'Song',
       
        }
    ],
    listening:[{
        type: mongoose.Schema.Types.ObjectId,
        ref:'Listen',
    }]

})

let User = mongoose.model('User', userSchema);

module.exports = User;
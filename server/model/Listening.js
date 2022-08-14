const mongoose  =  require('mongoose')

const listeningSchema = new mongoose.Schema({
    user:{
        type:mongoose.Schema.Types.ObjectId,
        ref:"User",
        require:true,
    },
    song:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Song',
        require:true,
    },
    time:{
        type:String,
        require:true,
    },
    timeEnd:{
        type:String,
        require:true,
    },

})

let Listen = mongoose.model('Listen', listeningSchema);

module.exports = Listen;
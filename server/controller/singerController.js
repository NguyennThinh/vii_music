const Singer = require('../model/Singer')


const singerController = {

    saveSinger: async(req, res)=>{
        try {
            const newSinger = new Singer(req.body)
            newSinger.save(newSinger).then(data=>{
                res.status(200).send(data)
            }).catch(err=>{

                res.status(500).send(err)
            })
        } catch (error) {
            
        }
    }
}


module.exports=singerController
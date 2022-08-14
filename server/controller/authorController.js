const Author = require('../model/Author')


const authorController = {

    saveAuthor: async(req, res)=>{
        try {
            const newSong = new Author(req.body)
            newSong.save(newSong).then(data=>{
                res.status(200).send(data)
            }).catch(err=>{

                res.status(500).send(err)
            })
        } catch (error) {
            
        }
    }
}


module.exports=authorController
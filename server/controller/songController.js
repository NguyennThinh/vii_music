const Song = require('../model/Song')
const Author = require('../model/Author')
const Singer = require('../model/Singer')
const User = require("../model/User");

const songController = {

    saveSong: (req, res)=>{
        try {
            const newSong = new Song(req.body)


            newSong.save(newSong).then(async data=>{
              

                if(req.body.author){
                    const author = Author.findById(req.body.author);
                    if(author){
                        await author.updateOne({$push:{songs:data._id}})
                    }
                }   
                if(req.body.singer){
                    const singer = Singer.findById(req.body.singer);
                    if(singer){
                        await singer.updateOne({$push:{songs:data._id}})
                    }
                }

                res.status(200).send(data)
                
            }).catch(err=>{

                res.status(500).send(err)
            })
        } catch (error) {
            
        }
    },

    getSongByListen: async(req, res)=>{
        try {
        
            const listSong = await Song.find().populate("singer").populate("author").sort({ listen: -1 });
            res.status(200).send(listSong)
        } catch (error) {
            res.status(500).send(error)
            
        }
    },
    getSongByCreate: async(req, res)=>{
        try {
        
            const listSong = await Song.find().populate("singer").populate("author").sort({ createAt: 1 });
            res.status(200).send(listSong)
        } catch (error) {
            res.status(500).send(error)
            
        }
    },
    likeSong: async(req, res)=>{
           
        try {
         await  Song.updateOne({_id:req.body.id_song},{$inc:{ like:1 }});
         await  User.updateOne({_id:req.body.id_user},{$push:{ likeSong: req.body.id_song}});
         res.status(200).send({message:"Like success"});
       
         
        } catch (error) {
     
            res.status(500).send(error)
        }
    },
    dislikeSong:async(req, res)=>{

        try {
            await   Song.updateOne({_id:req.body.id_song},{$inc:{ like:-1 }});
            await  User.updateOne({_id:req.body.id_user},{$pull:{likeSong:req.body.id_song}})
            res.status(200).send({message:"Dislike success"});
         } catch (error) {
             res.status(500).send(error)
         }

    },

    getSongs: async(req, res)=>{
        try {
            const listSong = await Song.find().populate("singer").populate("author");
            res.status(200).send(listSong);

        } catch (error) {
            
        }
    },
  
}


module.exports=songController
const User = require('../model/User');
const jwt = require('jsonwebtoken');
const bcrypt  = require('bcrypt');
const Listen = require('../model/Listening')

require('dotenv').config();

const userController = {
    //Sign up
    signup: async(req, res)=>{
            try{
                const satl = await bcrypt.genSalt(10)
                const hashPass = await bcrypt.hash(req.body.password, satl);


                const newUser =  User({
                    email:req.body.email,
                    password:hashPass,
                    name:req.body.name,
                    createAt:req.body.createAt,
                    updateAt:req.body.updateAt,
                    isAdmin:req.body.isAdmin
                })
               
                newUser.save(newUser).then(data=>{
                    res.status(200).json(data)
                }
                ).catch(err=>{
                    res.status(500).json({message:err})
                })
            }catch(err){
                console.log(err)
              
            }
    },

    //Login
    login: async(req, res)=>{
            try{
            var email = req.body.email
            var password = req.body.password
            var tokenLogin = req.body.token;
                
            if(tokenLogin){
            


                jwt.verify(tokenLogin, process.env.JWT_SECRETKEY,(err, data)=>{
       
                    if(err){
                        return res.status(400).send({
                            message:'Token Invaild'
                        })
                       
                    }
                    return res.status(200).send({
                        message:'Token vaild'
                    })
         
                       
                    })

            }else{
                User.findOne({
                    email:email
                }).then( async data=>{
                    if(!data){
                        res.status(400).send({message:"Không tìm thấy email"})
                    }else{
                        const isPassword = await bcrypt.compare( password, data.password)


                        if(!isPassword){
                            return  res.status(400).send({message:"Mật khẩu không đúng"})
                        }
                        var dataToken = ({
                            id:data.id,  
                            name:data.name,
                            email:data.email,
                            avatar:data.avatar
                        })
                      const token =  jwt.sign(dataToken,
                                                  process.env.JWT_SECRETKEY,{expiresIn: '60s'})
                        User.findOneAndUpdate({email:data.email},{tokenSession:token},(err, doc)=>{
                           
                                if(err) return res.status(500).send({message:'error'});
                                res.status(200).send({
                                    message:"Login success",
                                    token:token
                                })

                        })
                    
                    }
                }).catch(err=>{
                    console.log(err)
                    res.status(500).json(err)
                })
            }
            }catch(err){
                console.log(err)
            }
    },

    //update info user
    update: async(req, res)=>{
            try {
                var email = req.body.email
                console.log(req.file)
                if(req.file){
                    console.log(req.file)
                }else{
                    User.findOneAndUpdate({email:email}, req.body,(err, doc)=>{
                    
                        if(err) return res.status(500).send({message:'error'});
                        res.status(200).send({
                            message:"Update success"
                        })
                    })
                }
        
            } catch (error) {
                console.log(error)
            }
    },

    //List song listening
    savelistenSong: async(req, res)=>{
        try {
            const listening = new Listen(req.body) 
            const song =   Listen.find({
                "user":{"$inc":req.body.user},
                "song":{"$inc":req.body.song},
            });

            if(!song){
                listening.save(listening).then(async data=>{
                    const user =await User.findById({_id:req.body.user});
                    if(user){
                        await user.updateOne({$push:{listening:data._id}})
                        res.status(200).send(data)
                    }
                })
            }else{

               Listen.findOneAndUpdate({"song":req.body.song,
            "user":req.body.user},{
                $set : { 'time': req.body.time }, 
               
            }, {upsert: true, new: true},function(err, doc){
                if (err) return res.send(500, {error: err});

                res.status(200).send(doc)
            })
              
            }
           
        } catch (error) {
            console.log(error)
            res.status(500).send(error)
            
        }
    },


    songListen: async(req, res)=>{
            
     try {
        const user = await User.findOne({_id:req.params.id_user}).populate({
            path:"listening",
            populate: [
                { path: 'song',
            populate:'author singer' },
             
           
            ]
        });
 
        res.status(200).send(user.listening)
       

        

     } catch (error) {
        res.status(500).send(error)
     }
    },

      //List song liking
      likeSong: async(req, res)=>{
        try {

            const user = await User.findById({_id:req.body.id_user});
            if(user){
                const songLike= user.likeSong.find(id_song => id_song == req.body.id_song)
                if(songLike){
               return   res.status(200).send(songLike)

                }else{
                    return  res.status(400).send({message:"no like"})
                }
          
            }
        } catch (error) {
            console.log(error)
            res.status(500).send(error)
            
        }
    },
    getSongLikebyUser: async(req, res)=>{
        try {
            const user = await User.findOne({_id:req.params.id_user}).populate({
                path:"likeSong"
            })

            if (user) {
                res.status(200).send(user.likeSong);
            }
           

        } catch (error) {
            res.status(500).send(error)
            
        }
    }
}


module.exports = userController;
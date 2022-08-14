const express = require('express')
const mongoose = require('mongoose')
const morgan = require('morgan')
const app = express();
const http = require('http');
const fs = require('fs')
const server = http.createServer(app);
const bodyParser = require('body-parser');
require('dotenv').config()
const port = process.env.PORT||3000


const userRouter = require('./routes/user');
const authorRouter = require('./routes/author');
const singerRouter = require('./routes/singer');
const songRouter = require('./routes/song');


//connect db
mongoose.connect(process.env.MONGODB_URL, (callback)=>{
    if(callback){
        console.log("connect failL "+callback)
    }else{
        console.log("connect success: "+mongoose.connection.host)
    }
})


app.use(bodyParser.json({limit:'50mb'}))
app.use(morgan('common'))

//Router 
app.use('/api/v1/user', userRouter);
app.use('/api/v1/author', authorRouter);
app.use('/api/v1/singer', singerRouter);
app.use('/api/v1/song', songRouter);


server.listen(port, ()=>{
    console.log('server running port ', port);

});

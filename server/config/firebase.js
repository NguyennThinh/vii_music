var admin = require("firebase-admin");
const uuid = require('uuid-v4');
var serviceAccount = require("../firebase-key.json");
const path = require('path');
const console = require("console");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    storageBucket: "viimusic.appspot.com"
});

var bucket = admin.storage().bucket();


async function uploadFile(req, res) {
 
    const metadata = {
      metadata: {
        // This line is very important. It's to create a download token.
        firebaseStorageDownloadTokens: uuid()
      },
      contentType: 'image/png',
      contentType: 'image/jpg',
      cacheControl: 'public, max-age=31536000',
    };

    var filename =path.resolve(req.file.path)
    filename = filename.replace(/\\/g, '/');


   await  bucket.upload(filename, {
        // Support for HTTP requests made with `Accept-Encoding: gzip`
        gzip: true,
        metadata: metadata,
      }).then((data)=>{
        console .log(data[0].metadata)

        
        const fileUrl  = `https://firebasestorage.googleapis.com/v0/b/viimusic.appspot.com/o/${req.file.originalname}?alt=media&token=${data[0].metadata.metadata.firebaseStorageDownloadTokens}}`;
        console .log(fileUrl)
      });

  }

  module.exports = uploadFile
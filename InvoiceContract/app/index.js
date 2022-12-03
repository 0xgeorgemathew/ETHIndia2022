const express = require('express');
const Dotenv = require('dotenv');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const cors = require('cors');


const Sign = require('./routes/sign')

Dotenv.config({
  silent: true,
});
const app = express();
app.use('/api', Sign);
app.use(bodyParser.json({
  limit: '5000mb'
}));
app.use(bodyParser.urlencoded({
  extended: false,
  limit: '5000mb'
}));
app.use(cookieParser());
app.use(cors());


// app.use('/images', express.static(__dirname + '/images'));
// const uploadImg = multer({storage: storage}).single('image');



let server = app.listen(8086, async ()=> {
    let host = server.address().address
    let port = server.address().port
 
    console.log("Example app listening at http://%s:%s", host, port)
 })
 




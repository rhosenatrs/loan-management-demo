const express = require('express')
const jsforce = require('jsforce')
require('dotenv').config()
const app = express()
const port = 3001


const{SF_LOGIN_URL, SF_USERNAME, SF_PASSWORD, SF_TOKEN } = process.env


const conn = new jsforce.Connection({
    loginUrl: SF_LOGIN_URL
});

conn.login(SF_USERNAME, SF_PASSWORD+SF_TOKEN, function(err, res) {
    if (err) { return console.error(err); }
  });

app.get('/', (req, res)=>{
    conn.query("SELECT Id, Name FROM Account LIMIT 10", function(err, result) {
    if (err) { 
        res.send(err);
    }else{
        res.json(result.records);
    }
  });
})

app.listen(port, ()=> {
    console.log(`Server is running at http://localhost:${port}`)
})

const { Socket } = require('dgram');

const app = require('express')();
const server = require('http').createServer(app);
const options = { /* ... */ };
const io = require('socket.io')(server, options);
const port = 3484;

io.on('connection', client => {
    console.log(`New client connected`);
    client.on('fromClient', data => { 
        console.log(data); 
        client.emit('fromServer', `${Number(data)+1}`)
    })
    client.on('disconnect', () => console.log(`Client disconnected`))
});

server.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})

/*
const express = require('express')
const app = express()
const port = 3000

app.get('/',(req,res)=>{
    res.send('Hello World Nodejs')
})

app.listen(port, ()=>{
    console.log(`Example app listening at http://localhost:${port}`)
})
*/
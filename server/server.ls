express = require \express
app = express!

http = (require "http").Server app
io = (require "socket.io") http

port = Number (process.env.PORT || 3000)

players = require "./players.js"

app.use express.static \app

app.get "/players", (req, res) ->
  res.send players

app.post "/blue/goal", (req, res) ->
  io.emit "goal", team: "blue"
  res.send-status 200

app.post "/red/goal", (req, res) ->
  io.emit "goal", team: "red"
  res.send-status 200

io.on "connection", (socket) ->
  console.log "user connected"

  socket.on "disconnect", ->
    console.log "user disconnected"

http.listen port, ->
  console.log "offside server listening on port #{port}"

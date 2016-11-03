express = require \express
app = express!

players = require "./players.js"

app.use express.static \app

app.get "/players", (req, res) ->
  res.send players

app.listen 3000, ->
  console.log "offside server listening on port 3000"

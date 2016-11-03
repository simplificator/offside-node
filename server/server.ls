express = require \express
app = express!

app.use express.static \app

app.get "/players", (req, res) ->
  players =
    * id: 1
      name: "Thomas A"
    * id: 2
      name: "Mario"
    * id: 3
      name: "Sabine"
    * id: 4
      name: "Alessandro"
    * id: 5
      name: "Flo"

  res.send players


app.listen 3000, ->
  console.log "offside server listening on port 3000"

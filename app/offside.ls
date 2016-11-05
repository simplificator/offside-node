React-DOM = require \react-dom
Rx = require \rx
Rx-DOM = require \rx-dom
io = require "socket.io-client"

offside-store = require "./components/main/store.ls"
offside-ui = require "./components/main/ui.ls"


socket = io!

goal = Rx.Observable
  .from-event socket, "goal"
  .subscribe ({ team }) ->
    offside-store.dispatch do
      type: \goal
      payload: team


get-players = do
  Rx.DOM.ajax "/players"
  .subscribe ({ response }) ->
    offside-store.dispatch do
      type: \get-players
      payload: (JSON.parse response).filter (p) -> p.image_url


offside-store.subscribe ->
  state = offside-store.get-state!
  React-DOM.render (offside-ui state), (document.get-element-by-id \offside)

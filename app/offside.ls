React-DOM = require \react-dom
Rx = require \rx
Rx-DOM = require \rx-dom
io = require "socket.io-client"

offside-store = require "./stores/offside.ls"
offside-ui = require "./components/offside.ls"


socket = io!

goal = Rx.Observable
  .from-event socket, "goal"
  .subscribe ({ team }) ->
    offside-store.dispatch do
      type: \goal
      payload: team


start-game = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.id == "start-game"
  .subscribe (e) ->
    offside-store.dispatch do
      type: \start-game


set-player = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.class-name == "selectable-player"
  .subscribe (e) ->
    offside-store.dispatch do
      type: \set-player
      payload: e.target.id


free-slot = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.class-name == "selected-player"
  .subscribe (e) ->
    offside-store.dispatch do
      type: \free-slot
      payload: e.target.parent-element.id


get-players = do
  Rx.DOM.ajax "/players"
  .subscribe ({ response }) ->
    offside-store.dispatch do
      type: \get-players
      payload: (JSON.parse response).filter (p) -> p.image_url


offside-store.subscribe ->
  state = offside-store.get-state!
  React-DOM.render (offside-ui state), (document.get-element-by-id \offside)

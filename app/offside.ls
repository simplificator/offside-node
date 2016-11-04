React-DOM = require \react-dom
Rx = require \rx
Rx-DOM = require \rx-dom
io = require "socket.io-client"

match-maker-ui = require "./components/match-maker/ui.ls"

game-state =
  players: []
  slot1: undefined
  slot2: undefined
  slot3: undefined
  slot4: undefined


socket = io!
socket.on "goal", ->
  console.log "GOOOOOOOOOOOAAAAAAAAAAAAAAAAAAL"


update-state = (state, [action, params]) ->
  switch action
    case \get-players
      state.players = params
      state
    case \set-player
      player-id = params
      slot = find-available-slot state
      state[slot] = state.players.find (p) -> p.id == +player-id
      state
    case \free-slot
      slot-id = params
      state[slot-id] = undefined
      state
    default state



find-available-slot = (state) ->
  "slot" + [1 to 4].find (i) ->
    !state["slot#{i}"]



start-game = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.id == "start-game"
  .map (e) ->
    [\start-game]


set-player = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.class-name == "selectable-player"
  .map (e) ->
    [\set-player, e.target.id]



free-slot = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.class-name == "selected-player"
  .map (e) ->
    [\free-slot, e.target.parent-element.id]



# render stuff


get-players = do
  Rx.DOM
    .ajax "/players"
    .map ({ response }) ->
      [\get-players, (JSON.parse response).filter (p) -> p.image_url]


Rx.Observable.merge [get-players, set-player, free-slot, start-game]
  .do (x) -> console.log x
  .scan update-state, game-state
  .subscribe (state) ->
    React-DOM.render (match-maker-ui state), (document.get-element-by-id \offside)

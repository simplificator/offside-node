React-DOM = require \react-dom
Rx = require \rx
Rx-DOM = require \rx-dom
io = require "socket.io-client"

offside-ui = require "./components/offside.ls"


game-state =
  players: []
  slot1: undefined
  slot2: undefined
  slot3: undefined
  slot4: undefined
  match:
    running:false
    red:
      team: []
      score: 0
    blue:
      team: []
      score: 0


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
    case \start-game
      state.match.red.team = [state.slot1, state.slot2]
      state.match.blue.team = [state.slot3, state.slot4]
      state.match.running = true
      state
    case \goal
      team = params
      state.match[team].score = state.match[team].score + 1
      state
    case \end-game
      state.match.running = false
      state

    default state



find-available-slot = (state) ->
  "slot" + [1 to 4].find (i) ->
    !state["slot#{i}"]


socket = io!

goal = Rx.Observable
  .from-event socket, "goal"
  .map ({ team }) ->
    console.log team
    console.log arguments
    [\goal, team]


start-game = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.id == "start-game"
  .map (e) ->
    [\start-game]


# end-game = Rx.Observable
#   .from-event (document.get-element-by-id "end-game"), \mousedown
#   .filter (e) ->
#     e.target.id == "end-game"
#   .map (e) ->
#     [\end-game]


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


Rx.Observable.merge [get-players, set-player, free-slot, start-game, goal]
  .do (x) -> console.log x
  .scan update-state, game-state
  .subscribe (state) ->
    React-DOM.render (offside-ui state), (document.get-element-by-id \offside)

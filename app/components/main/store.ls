{ create-store } = require \redux

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


update-state = (state, { type, payload }) ->
  switch type
    case \get-players then get-players state, payload
    case \set-player then set-player state, payload
    case \shuffle-players then shuffle-players state
    case \free-slot then free-slot state, payload
    case \start-game then start-game state
    case \goal then goal state, payload
    case \end-game then end-game state
    default state


get-players = (state, players) ->
  state.players = players
  state

set-player = (state, player-id) ->
  slot = find-available-slot state
  state[slot] = state.players.find (p) -> p.id == +player-id
  state

shuffle-players = (state) ->
  { slot1, slot2, slot3, slot4 } = state
  state.slot1 = slot4
  state.slot2 = slot3
  state.slot3 = slot1
  state.slot4 = slot2
  state

free-slot = (state, slot-id) ->
  state[slot-id] = undefined
  state

start-game = (state) ->
  { slot1, slot2, slot3, slot4 } = state
  player-count = ([slot1, slot2, slot3, slot4].filter (x) -> x).length
  if player-count == 4
    state.match.red.team = [state.slot1, state.slot2]
    state.match.blue.team = [state.slot3, state.slot4]
    state.match.running = true
  state

goal = (state, team) ->
  if state.match.running
    state.match[team].score = state.match[team].score + 1
  state

end-game = (state) ->
  state.slot1 = undefined
  state.slot2 = undefined
  state.slot3 = undefined
  state.slot4 = undefined
  state.match =
    running:false
    red:
      team: []
      score: 0
    blue:
      team: []
      score: 0
  state


find-available-slot = (state) ->
  "slot" + [1 to 4].find (i) ->
    !state["slot#{i}"]

store = create-store update-state, game-state

module.exports = store

choose-player-sound = require "../../sounds/choose-player.mp3"

initial-state =
  players: []
  slot1: undefined
  slot2: undefined
  slot3: undefined
  slot4: undefined


get-players = (state, players) ->
  { ...state, players }


choose-player = (state, player-id) ->
  player = state.players.find (p) -> p.id == +player-id
  slot = find-available-slot state

  unless !slot || player in get-selected-players state
    (new Audio choose-player-sound).play!
    { ...state, "#slot": player }
  else
    state


# TODO: do this properly
shuffle-players = (state) ->
  state


free-slot = (state, slot-id) ->
  { ...state, "#slot-id": undefined }


end-game = (state) ->
  {
    ...state
    slot1: undefined
    slot2: undefined
    slot3: undefined
    slot4: undefined
  }


get-selected-players = (state) ->
  { slot1, slot2, slot3, slot4 } = state
  [slot1, slot2, slot3, slot4].filter (x) -> x


find-available-slot = (state) ->
  id = [1 to 4].find (i) -> !state["slot#{i}"]
  "slot#{id}" if id


module.exports = (state = initial-state, { type, payload }) ->
  switch type
    case \PLAYERS_SET then get-players state, payload
    case \PLAYER_CHOOSE then choose-player state, payload
    case \PLAYERS_SHUFFLE then shuffle-players state
    case \SLOT_FREE then free-slot state, payload
    case \GAME_END then end-game state
    default state

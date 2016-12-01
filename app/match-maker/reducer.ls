initial-state =
  time-to-start: undefined
  players: []
  slot1: undefined
  slot2: undefined
  slot3: undefined
  slot4: undefined


set-players = (state, players) ->
  { ...state, players }


choose-player = (state, player-id) ->
  player = state.players.find (p) -> p.id == +player-id
  slot = find-available-slot state

  unless !slot || player in get-selected-players state
    { ...state, "#slot": player }
  else
    state


# TODO: do this properly
shuffle-players = (state) ->
  state


free-slot = (state, slot-id) ->
  { ...state, "#slot-id": undefined }


reset-slots = (state) ->
  {
    ...state
    time-to-start: undefined
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


start-game-in = (state, time-to-start) ->
  { ...state, time-to-start }


module.exports = (state = initial-state, action) ->
  switch action.type
    case \PLAYERS_SET then set-players state, action.players
    case \PLAYER_CHOOSE then choose-player state, action.id
    case \PLAYERS_SHUFFLE then shuffle-players state
    case \SLOT_FREE then free-slot state, action.id
    case \GAME_STARTS_IN_3 then start-game-in state, 3
    case \GAME_STARTS_IN_2 then start-game-in state, 2
    case \GAME_STARTS_IN_1 then start-game-in state, 1
    case \GAME_START then reset-slots state
    default state

{ create-store } = require \redux

match-maker-update-state = require "./components/match-maker/update-state.ls"
score-board-update-state = require "./components/score-board/update-state.ls"


game-state =
  players: []
  slot1: undefined
  slot2: undefined
  slot3: undefined
  slot4: undefined
  match:
    running:false
    red:
      players: []
      goals: 0
    blue:
      players: []
      goals: 0


update-state = (state, { type, payload }) ->
  switch type
    case \PLAYERS_SET
        ,\PLAYER_CHOOSE
        ,\PLAYERS_SHUFFLE
        ,\SLOT_FREE
        ,\GAME_START
          match-maker-update-state ...
    case \GOAL_ADD
        ,\GAME_END
          score-board-update-state ...
    default state


module.exports = create-store update-state, game-state
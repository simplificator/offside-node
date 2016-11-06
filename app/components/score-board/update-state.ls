

goal-up = (state, team) ->
  set-score state, team, state.match[team].goals + 1


goal-down = (state, team) ->
  set-score state, team, state.match[team].goals - 1


set-score = (state, team, score) ->
  if state.match.running && score >= 0 && score <= 8
    state.match[team].goals = score
  state


end-game = (state) ->
  state.slot1 = undefined
  state.slot2 = undefined
  state.slot3 = undefined
  state.slot4 = undefined
  state.match =
    running:false
    red:
      players: []
      goals: 0
    blue:
      players: []
      goals: 0
  state


module.exports = (state, { type, payload }) ->
  switch type
    case \GOAL_ADD then goal-up state, payload
    case \GOAL_UP then goal-up state, payload
    case \GOAL_DOWN then goal-down state, payload
    case \GAME_END then end-game state
    default state

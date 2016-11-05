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

module.exports = (state, { type, payload }) ->
  switch type
    case \GOAL_ADD then goal state, payload
    case \GAME_END then end-game state
    default state

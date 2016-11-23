
initial-state =
  running:false
  goals: []
  red:
    players: []
    score: 0
  blue:
    players: []
    score: 0


goal-up = (state, team) ->
  set-score state, team, state[team].score + 1


goal-down = (state, team) ->
  set-score state, team, state[team].score - 1


set-score = (state, team, score) ->
  if state.running && score >= 0 && score <= 8
    { ...state, "#team": { ...state[team], score } }
  else
    state


start-game = (state, { slot1, slot2, slot3, slot4 }) ->
  {
    ...initial-state
    running: true
    red:
      players: [slot1, slot2]
      score: 0
    blue:
      players: [slot3, slot4]
      score: 0
  }


end-game = (state) ->
  initial-state


module.exports = (state = initial-state, { type, payload }) ->
  switch type
    case \GOAL_ADD then goal-up state, payload
    case \GOAL_UP then goal-up state, payload
    case \GOAL_DOWN then goal-down state, payload
    case \GAME_START then start-game state, payload
    case \GAME_END then end-game state, payload
    default state

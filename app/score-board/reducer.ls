initial-state =
  running: false
  team1:
    players: []
    rounds-won: 0
  team2:
    players: []
    rounds-won: 0
  rounds: []
  current-score: undefined

initial-score =
  goals: []
  team1:
    side: "red"
    score: 0
  team2:
    side: "blue"
    score: 0


goal-up = (state, side) ->
  update-score state, side, +1


goal-down = (state, side) ->
  update-score state, side, -1


find-team-by-side = (current-score, side) ->
  current-score.team1.side == side && "team1" || "team2"


update-score = (state, side, delta-value) ->
  if state.running
    team = find-team-by-side state.current-score, side
    score = enforce-score-boundaries <| state.current-score[team].score + delta-value
    current-score = { ...state.current-score, "#team": { ...state[team], score } }
    { ...state, current-score }
  else
    state


enforce-score-boundaries = (score) ->
  Math.min 8, Math.max 0, score


start-game = (state, { slot1, slot2, slot3, slot4 }) ->
  {
    ...initial-state
    running: true
    team1:
      players: [slot1, slot2]
      rounds-won: 0
    team2:
      players: [slot3, slot4]
      rounds-won: 0
    current-score: initial-score
  }


end-game = ->
  initial-state


module.exports = (state = initial-state, action) ->
  switch action.type
    case \GOAL_ADD then goal-up state, action.team
    case \GOAL_UP then goal-up state, action.team
    case \GOAL_DOWN then goal-down state, action.team
    case \GAME_START then start-game state, action.players
    case \GAME_END then end-game state
    default state

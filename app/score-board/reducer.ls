initial-state =
  winner: undefined
  running: false
  switch-sides-in: undefined
  team1:
    players: []
    rounds-won: 0
  team2:
    players: []
    rounds-won: 0
  rounds: []
  current-score: undefined

initial-score =
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
    current-score = { ...state.current-score, "#team": { ...state.current-score[team], score } }
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


switch-sides-countdown = (state, switch-sides-in) ->
 { ...state, switch-sides-in }


switch-sides = ({ current-score, rounds }:state) ->
  { team1, team2 } = current-score
  {
    ...state
    switch-sides-in: undefined
    rounds: [...rounds, current-score]
    current-score:
      team1:
        score: 0
        side: team2.side
      team2:
        score: 0
        side: team1.side
  }


congratulate-winner = (state, winner) ->
  { ...state, winner }


end-game = ->
  initial-state


module.exports = (state = initial-state, action) ->
  switch action.type
    case \GOAL_UP then goal-up state, action.team
    case \GOAL_DOWN then goal-down state, action.team
    case \GAME_START then start-game state, action.players
    case \SWITCH_SIDES_COUNTDOWN then switch-sides-countdown state, action.time
    case \SWITCH_SIDES then switch-sides state
    case \CONGRATULATE_WINNER then congratulate-winner state, action.winner
    case \GAME_END then end-game state
    default state

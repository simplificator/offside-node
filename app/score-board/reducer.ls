MAX_GOALS = 8

initial-state =
  winner: undefined
  running: false
  switch-sides-in: undefined
  team1:
    players: []
  team2:
    players: []
  rounds: []
  current-score: undefined

initial-score =
  team1:
    side: "red"
    goals: []
    score: 0
  team2:
    side: "blue"
    goals: []
    score: 0


goal-down = ({ current-score }:state, side) ->
  if !state.running
    state
  else
    team = find-team-by-side current-score, side
    [...goals, invalid-goal] = current-score[team].goals
    score = goals.length
    team-score = { ...current-score[team], score, goals }
    { ...state, current-score: { ...current-score, "#team": team-score } }


goal-up = ({ current-score }:state, side) ->
  if !state.running
    state
  else
    team = find-team-by-side current-score, side
    goals = [...current-score[team].goals, new Date]

    if goals.length <= MAX_GOALS
      score = goals.length
      team-score = { ...current-score[team], score, goals }
      { ...state, current-score: { ...current-score, "#team": team-score } }
    else
      state


find-team-by-side = (current-score, side) ->
  current-score.team1.side == side && "team1" || "team2"


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
        side: team2.side
        score: 0
        goals: []
      team2:
        score: 0
        side: team1.side
        goals: []
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
    case \GAME_CANCEL then end-game state
    case \GAME_END then end-game state
    default state

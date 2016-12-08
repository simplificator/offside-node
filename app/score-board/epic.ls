{ Observable } = require \rxjs
{ combine-epics } = require \redux-observable


switch-sides = (action$, { get-state }) ->
  action$
    .of-type \GOAL_UP
    .map -> get-state().score-board
    .switch-map switch-sides-or-end-game


switch-sides-or-end-game = ({ current-score, rounds }) ->
  winner = round-won-by current-score
  if winner && game-won current-score, rounds
    Observable.from [{ type: \CONGRATULATE_WINNER, winner }]
  else if winner
    switch-sides-countdown$
  else
    Observable.from []


round-won-by = ({ team1, team2 }) ->
  team1.score == 8 && "team1" || team2.score == 8 && "team2"


game-won = (current-score, rounds) ->
  { team1, team2 } = count-won-rounds [...rounds, current-score]
  team1 == 3 || team2 == 3


count-won-rounds = (rounds) ->
  rounds
    .reduce (acc, round) ->
      winner = round-won-by round
      { ...acc, "#winner": acc[winner] + 1 }
    , { team1: 0, team2: 0 }


switch-sides-countdown$ = do
  Observable
    .from [
      { type: \SWITCH_SIDES_COUNTDOWN, time: 5 },
      { type: \SWITCH_SIDES_COUNTDOWN, time: 4 },
      { type: \SWITCH_SIDES_COUNTDOWN, time: 3 },
      { type: \SWITCH_SIDES_COUNTDOWN, time: 2 },
      { type: \SWITCH_SIDES_COUNTDOWN, time: 1 },
      { type: \SWITCH_SIDES } ]
    .zip (Observable.interval 1000), (a, b) -> a


end-game = (action$, { get-state }) ->
  action$
    .of-type \TRIGGER_GAME_END
    .do ->
      { score-board } = get-state!
      persist-score score-board
    .map-to { type: \GAME_END }


persist-score = ({ team1, team2, rounds, winner }) ->
  # TODO:
  # somewhere start/get the pouchdb
  # persist match data
  # replicate db


module.exports = combine-epics end-game, switch-sides

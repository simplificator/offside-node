{ Observable } = require \rxjs
{ combine-epics } = require \redux-observable


switch-sides = (action$, { get-state }) ->
  action$
    .of-type \GOAL_UP
    .filter -> round-won get-state!
    .switch-map switch-sides-countdown


round-won = ({ score-board: { current-score } }) ->
  current-score.team1.score == 8 || current-score.team2.score == 8


switch-sides-countdown = ->
  Observable
    .from [
      { type: \SWITCH_SIDES_IN, time: 5 },
      { type: \SWITCH_SIDES_IN, time: 4 },
      { type: \SWITCH_SIDES_IN, time: 3 },
      { type: \SWITCH_SIDES_IN, time: 2 },
      { type: \SWITCH_SIDES_IN, time: 1 },
      { type: \SWITCH_SIDES } ]
    .zip (Observable.interval 1000), (a, b) -> a


module.exports = combine-epics switch-sides

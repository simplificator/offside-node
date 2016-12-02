{ Observable } = require \rxjs
{ combine-epics } = require \redux-observable


switch-sides = (action$, { get-state }) ->
  action$
    .of-type \GOAL_UP
    .filter ->
      { score-board: { current-score } } = get-state!
      current-score.team1.score == 8 || current-score.team2.score == 8
    .map-to { type: \SWITCH_SIDES }


find-team-by-side = (current-score, side) ->
  current-score.team1.side == side && "team1" || "team2"


module.exports = combine-epics switch-sides

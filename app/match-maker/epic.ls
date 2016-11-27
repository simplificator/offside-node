{ Observable } = require \rxjs
{ combine-epics } = require \redux-observable


play-coin-sound = (action$) ->
  action$
    .of-type \PLAYER_CHOOSE
    .map-to { type: \SOUND_COIN }


game-start-animation = (action$) ->
  action$
    .of-type \GAME_START_TRIGGER
    .switch-map ({ players }) ->
      Observable
        .from [\GAME_STARTS_IN_3, \GAME_STARTS_IN_2, \GAME_STARTS_IN_1, \GAME_START]
        .zip (Observable.interval 600), (a, b) -> a
        .map (type) ->
          { type, players }


module.exports = combine-epics play-coin-sound, game-start-animation

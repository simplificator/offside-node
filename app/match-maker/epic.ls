require \rxjs

module.exports = (action$) ->
  action$
    .of-type \PLAYER_CHOOSE
    .map-to { type: \SOUND_COIN }

choose-player-sound = require "./assets/choose-player.mp3"


play-coin-sound = (state) ->
  (new Audio choose-player-sound).play!
  state


module.exports = (state = 0, action) ->
  switch action.type
    case \SOUND_COIN then play-coin-sound state
    default state

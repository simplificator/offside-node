choose-player-sound = require "./assets/choose-player.mp3"


play-coin-sound = ->
  # (new Audio choose-player-sound).play!


module.exports = (state = 0, action) ->
  switch action.type
    case \SOUND_PLAYER_CHOSEN then play-coin-sound

  state

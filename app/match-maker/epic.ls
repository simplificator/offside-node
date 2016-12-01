{ Observable } = require \rxjs
{ combine-epics } = require \redux-observable


fetch-players = (action$) ->
  action$
    .of-type \FETCH_PLAYERS
    .switch-map ->
      Observable
        .ajax
        .get "/players"
        .retry 5
        .map ({ response }) ->
          players = response.filter (p) -> p.image_url
          { type: \PLAYERS_SET, players }


player-chosen-sound = (action$) ->
  action$
    .of-type \PLAYER_CHOOSE
    .map-to { type: \SOUND_PLAYER_CHOSEN }


game-start-animation = (action$) ->
  action$
    .of-type \GAME_START_TRIGGER
    .switch-map ({ players }) ->
      Observable
        .from [\GAME_STARTS_IN_2, \GAME_STARTS_IN_1, \GAME_START]
        .zip (Observable.interval 800), (a, b) -> a
        .start-with \GAME_STARTS_IN_3
        .map (type) ->
          { type, players }


module.exports = combine-epics player-chosen-sound, game-start-animation, fetch-players

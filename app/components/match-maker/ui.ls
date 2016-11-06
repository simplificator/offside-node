React = require \react
Rx = require \rx
Rx-DOM = require \rx-dom

store = require "../../store.ls"
require "./style.scss"

{ h1, div, ul, li, img, a } = React.DOM


Rx.DOM
  .ajax "/players"
  .subscribe ({ response }) ->
    store.dispatch do
      type: \PLAYERS_SET
      payload: (JSON.parse response).filter (p) -> p.image_url


d = (type, payload) ->
  ->
    store.dispatch { type, payload }


player-slots = ({ slot1, slot2, slot3, slot4 }) ->
  div { class-name: "player-slots" },
    div { class-name: "team-red" },
      slot { id:1, player:slot1 }
      slot { id:2, player:slot2 }
    div { class-name: "field"},
      img { src: require "./field-img-white.png" }
    div { class-name: "team-blue" },
      slot { id:3, player:slot3 }
      slot { id:4, player:slot4 }


slot = ({ id, player }) ->
  div { class-name: "slot" },
    if player
      img { src: player.image_url, on-click: (d \SLOT_FREE, "slot#{id}") }
    else
      id


game-buttons = ({ game-can-start }) ->
  class-name = if game-can-start then "button active" else "button"
  div { class-name: "game-buttons" },
    a { class-name, on-click: d \GAME_START }, "Start Game"
    a { class-name, on-click: d \PLAYERS_SHUFFLE }, "Shuffle Teams"


players-to-choose = ({ players, selected-players }) ->
  div { class-name: "players-to-choose" },
    players.map (player) ->
      class-name = "selectable-player" unless player in selected-players
      div { class-name: "player" },
        img { src: player.image_url, on-click: (d \PLAYER_CHOOSE, player.id), class-name }


module.exports = ({ players, slot1, slot2, slot3, slot4 }) ->
  selected-players = [slot1, slot2, slot3, slot4].filter (x) -> x
  game-can-start = selected-players.length == 4

  div { class-name: "match-maker" },
    player-slots { slot1, slot2, slot3, slot4 }
    game-buttons { game-can-start }
    if players?
      players-to-choose { players, selected-players }

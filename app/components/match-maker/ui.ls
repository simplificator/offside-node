React = require \react
{ h1, div, ul, li, img, a } = React.DOM

require "./style.scss"


ui = ({ players, slot1, slot2, slot3, slot4 }) ->
  div { class-name: "offside-main" },
    h1 {}, "choose players"
    start-match-ui { slot1, slot2, slot3, slot4 }
    game-buttons { slots: [slot1, slot2, slot3, slot4] }
    player-chooser { players, selected-players: [slot1, slot2, slot3, slot4] } if players?


start-match-ui = ({ slot1, slot2, slot3, slot4 }) ->
  div { class-name: "start-match-ui" },
    div { class-name: "blue" },
      player-slot { name:"slot1", player:slot1, number: 1 }
      player-slot { name:"slot2", player:slot2, number: 2 }
    div { class-name: "red" },
      player-slot { name:"slot3", player:slot3, number: 3 }
      player-slot { name:"slot4", player:slot4, number: 4 }


game-buttons = ({ slots }) ->
  class-name = "active" if (slots.filter (x) -> x).length == 4
  div { class-name: "game-buttons" },
    a { class-name }, "Start Game"
    a { class-name }, "Shuffle Teams"


player-chooser = ({ players, selected-players }) ->
  div { class-name: "player-chooser" },
    players.map (player) ->
      class-name = "selectable-player" unless player in selected-players
      div { class-name: "player" },
        player-icon { player, class-name }


player-icon = ({ player, class-name }) ->
  img { src:player.image_url, id: player.id, class-name: class-name }


player-slot = ({ name, player, number }) ->
  div { id: name, class-name: "slot" },
    if player
      player-icon { player, class-name: "selected-player" }
    else
      number

module.exports = ui

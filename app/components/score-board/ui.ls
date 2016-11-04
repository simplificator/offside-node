React = require \react
{ h1, div, ul, li, img, a } = React.DOM

require "./style.scss"


ui = ({ red, blue }) ->
  div {},
    div { class-name: "score-board" },
      div { class-name: "red-side" },
        score { count: red.score }
        team { players:red.team }
      div { class-name: "seperator" }
      div { class-name: "blue-side" },
        score { count: blue.score }
        team { players:blue.team }
    div { class-name: "score-buttons" },
      a { id: "end-game", class-name: "button active" }, "end game"


score = ({ count }) ->
  div { class-name: "score-count" }, count


team = ({ players }) ->
  div { class-name: "team" },
    player-icon { player: players[0] }
    player-icon { player: players[1] }

player-icon = ({ player, class-name }) ->
  img { src:player.image_url, id: player.id, class-name: "player-icon" }


module.exports = ui

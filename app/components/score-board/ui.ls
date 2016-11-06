React = require \react
io = require "socket.io-client"

{ h1, div, ul, li, img, a } = React.DOM

{ dispatch } = require "../../store.ls"

require "./style.scss"

socket = io!

socket.on "goal", ({ team }) ->
  dispatch do
    type: \GOAL_ADD
    payload: team


score = ({ goals, team }) ->
  div { class-name: "score" },
    div { class-name: "score-manipulator" },
      a { on-click: -> dispatch type: \GOAL_UP, payload: team }, "+"
    div { class-name: "score-count" },
      div { id: "count-#{goals}"},
        [0 to 8].map (i) ->
          div {}, i
    div { class-name: "score-manipulator" },
      a { on-click: -> dispatch type: \GOAL_DOWN, payload: team }, "-"


players = ({ players }) ->
  div { class-name: "team" },
    img { src:players[0].image_url, class-name: "player-icon" }
    img { src:players[1].image_url, class-name: "player-icon" }


buttons = ->
  div { class-name: "score-buttons" },
    a { class-name: "button active", on-click: -> dispatch type: \GAME_END }, "end game"


module.exports = ({ red, blue }) ->
  div {},
    div { class-name: "score-board" },
      div { class-name: "red-side" },
        score { goals: red.score, team: "red" }
        players { players: red.players }
      div { class-name: "seperator" }
      div { class-name: "blue-side" },
        score { goals: blue.score, team: "blue" }
        players { players: blue.players }
    buttons {}

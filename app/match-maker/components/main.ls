{ create-element, DOM } = require \react
{ div } = DOM

slots = require "./slots.ls"
buttons = require "./buttons.ls"
players = require "./players.ls"
start-screen = require "./start-screen.ls"

require "./style.scss"


module.exports = ->
  div { class-name: "match-maker" },
    create-element start-screen, {}
    create-element slots, {}
    create-element buttons, {}
    create-element players, {}

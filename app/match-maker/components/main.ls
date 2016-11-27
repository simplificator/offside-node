{ create-element, DOM } = require \react
{ div } = DOM

slots = require "./slots.ls"
buttons = require "./buttons.ls"
players = require "./players.ls"

require "./style.scss"


module.exports = ->
  div { class-name: "match-maker" },
    create-element slots, {}
    create-element buttons, {}
    create-element players, {}

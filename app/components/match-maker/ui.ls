React = require \react

slots = require "./slots.ls"
buttons = require "./buttons.ls"
players = require "./players.ls"
require "./style.scss"

{ div } = React.DOM

module.exports = ->
  div { class-name: "match-maker" },
    React.create-element slots, {}
    React.create-element buttons, {}
    React.create-element players, {}

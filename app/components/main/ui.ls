React = require \react
{ div } = React.DOM

match-maker-ui = require "../match-maker/ui.ls"
score-board-ui = require "../score-board/ui.ls"

require "./style.scss"

module.exports = ->
  div {},
    match-maker-ui {}
    score-board-ui {}

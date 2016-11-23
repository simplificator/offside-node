React = require \react
{ div } = React.DOM

match-maker-ui = require "../match-maker/ui.ls"
score-board-ui = require "../score-board/ui.ls"

require "./style.scss"

module.exports = ({ match-maker, score-board }) ->
  div {},
    match-maker-ui match-maker
    if score-board.running
      score-board-ui score-board

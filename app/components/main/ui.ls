React = require \react
{ div } = React.DOM

match-maker = require "../match-maker/ui.ls"
score-board = require "../score-board/ui.ls"

require "./style.scss"

module.exports = (props) ->
  div {},
    match-maker props
    if props.match.running
      score-board props.match

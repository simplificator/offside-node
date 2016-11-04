React = require \react
{ h1, div, ul, li, img, a } = React.DOM

match-maker = require "./match-maker/ui.ls"
score-board = require "./score-board/ui.ls"

require "./style.scss"


ui = (props) ->
  div {},
    match-maker props
    if props.match.running
      score-board props.match


module.exports = ui

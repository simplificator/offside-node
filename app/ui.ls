{ DOM } = require \react
{ div } = DOM

match-maker-ui = require "./match-maker/components/main.ls"
score-board-ui = require "./score-board/components/main.ls"

require "./style.scss"

module.exports = ->
  div {},
    match-maker-ui {}
    score-board-ui {}

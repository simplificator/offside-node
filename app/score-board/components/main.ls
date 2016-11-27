{ create-element, DOM } = require \react
{ connect } = require \react-redux
{ div } = DOM

score = require "./score.ls"
buttons = require "./buttons.ls"

require "./style.scss"


ui = ({ running }) ->
  if !running
    div {}
  else
    div { class-name: "score-board" },
      create-element score, {}
      create-element buttons, {}


map-state-to-props = ({ score-board: { running } }) ->
  { running }


enhanced-ui = do
  ui |> connect map-state-to-props, null


module.exports = ->
  div {},
    create-element enhanced-ui, {}

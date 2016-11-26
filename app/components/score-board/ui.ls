React = require \react
{ connect } = require \react-redux
{ div } = React.DOM

score = require "./score.ls"
buttons = require "./buttons.ls"

require "./style.scss"


ui = ({ running }) ->
  if !running
    div {}
  else
    div { class-name: "score-board" },
      React.create-element score, {}
      React.create-element buttons, {}


map-state-to-props = ({ score-board: { running } }) ->
  { running }


enhanced-ui = do
  ui |> connect map-state-to-props, null


module.exports = ->
  div {},
    React.create-element enhanced-ui, {}

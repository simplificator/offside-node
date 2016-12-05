{ create-element, DOM } = require \react
{ connect } = require \react-redux
{ div } = DOM

switching-sides = require "./switching-sides.ls"
end-screen = require "./end-screen.ls"
score = require "./score.ls"
buttons = require "./buttons.ls"

require "./style.scss"


ui = ({ running }) ->
  if !running
    div {}
  else
    div { class-name: "score-board" },
      create-element score, {}
      create-element switching-sides, {}
      create-element end-screen, {}
      create-element buttons, {}


map-state-to-props = ({ score-board: { running } }) ->
  { running }


enhanced-ui = do
  ui |> connect map-state-to-props, null


module.exports = ->
  div {},
    create-element enhanced-ui, {}

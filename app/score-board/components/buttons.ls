{ connect } = require \react-redux
{ div, a } = (require \react).DOM


buttons = ({ winner, on-end-click }) ->
  if winner?
    div {}
  else
    div { class-name: "score-buttons" },
      a { class-name: "button active", on-click: on-end-click }, "end game"


map-state-to-props = ({ score-board: { winner } }) ->
  { winner }


map-dispatch-to-props = (dispatch) ->
  on-end-click: -> dispatch { type: \GAME_CANCEL }


module.exports = do
  buttons |> connect map-state-to-props, map-dispatch-to-props

{ connect } = require \react-redux
{ div, a } = (require \react).DOM


buttons = ({ on-end-click }) ->
  div { class-name: "score-buttons" },
    a { class-name: "button active", on-click: -> on-end-click }, "end game"


map-dispatch-to-props = (dispatch) ->
  on-end-click: -> dispatch { type: \GAME_END }


module.exports = do
  buttons |> connect null, map-dispatch-to-props

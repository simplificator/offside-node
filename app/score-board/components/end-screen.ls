{ connect } = require \react-redux
{ div, a } = (require \react).DOM


end-screen = ({ winner, on-end-click, on-undo-click }) ->
  if !winner?
    div {}
  else
    div { class-name: "end-screen" },
      div {}, "Nicely done, #{winner}!"
      a { class-name: "button active", on-click: on-end-click }, "end game"
      a { class-name: "button active", on-click: on-undo-click }, "undo last goal"


map-state-to-props = ({ score-board: { winner } }) ->
  { winner }


map-dispatch-to-props = (dispatch) ->
  on-end-click: -> dispatch { type: \TRIGGER_GAME_END }
  on-undo-click: -> dispatch { type: \CANCEL_GAME_WON }


module.exports = do
  end-screen |> connect map-state-to-props, map-dispatch-to-props

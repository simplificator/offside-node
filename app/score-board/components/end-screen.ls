{ connect } = require \react-redux
{ div, a } = (require \react).DOM


end-screen = ({ winner, on-cancel-click }) ->
  if !winner?
    div {}
  else
    div { class-name: "end-screen" },
      div {}, "Nicely done, #{winner}!"


map-state-to-props = ({ score-board: { winner } }) ->
  { winner }


map-dispatch-to-props = (dispatch) ->
  on-cancel-click: -> dispatch { type: \CANCEL_GAME_WON }


module.exports = do
  end-screen |> connect map-state-to-props, map-dispatch-to-props

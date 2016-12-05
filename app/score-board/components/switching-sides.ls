{ connect } = require \react-redux
{ div } = (require \react).DOM


switching-sides = ({ switch-sides-in }) ->
  if !switch-sides-in
    div {}
  else
    div { class-name: "switching-sides" },
      "switching sides in"
      div { class-name: "time" }, switch-sides-in


map-state-to-props = ({ score-board: { switch-sides-in } }) ->
  { switch-sides-in }


map-dispatch-to-props = (dispatch) ->
  on-cancel-click: -> dispatch { type: \CANCEL_SWITCH_SIDES }


module.exports = do
  switching-sides |> connect map-state-to-props, map-dispatch-to-props

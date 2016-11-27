{ connect } = require \react-redux
{ div, a } = (require \react).DOM


buttons = ({ game-can-start, slot1, slot2, slot3, slot4, on-start-click }) ->
  class-name = if game-can-start then "button active" else "button"
  div { class-name: "game-buttons" },
    a { class-name, on-click: -> on-start-click { slot1, slot2, slot3, slot4 } }, "Start Game"
    a { class-name }, "Shuffle Teams"


map-state-to-props = ({ match-maker: { players, slot1, slot2, slot3, slot4 }}) ->
  game-can-start = ([slot1, slot2, slot3, slot4].filter (x) -> x).length == 4
  { game-can-start, slot1, slot2, slot3, slot4 }


map-dispatch-to-props = (dispatch) ->
  on-start-click: (players) -> dispatch { type: \GAME_START, players }


module.exports = do
  buttons |> connect map-state-to-props, map-dispatch-to-props

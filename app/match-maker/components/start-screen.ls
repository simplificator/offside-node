{ connect } = require \react-redux
{ div } = (require \react).DOM


game-start-screen = ({ time-to-start, slot1, slot2, slot3, slot4, on-slot-click }) ->
  if !time-to-start
    div {}
  else
    div { class-name: "game-start-screen" }, time-to-start


map-state-to-props = ({ match-maker: { time-to-start, slot1, slot2, slot3, slot4 }}) ->
  { time-to-start, slot1, slot2, slot3, slot4 }


module.exports = do
  game-start-screen |> connect map-state-to-props

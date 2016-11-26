{ connect } = require \react-redux
{ div, img } = (require \react).DOM


slots = ({ slot1, slot2, slot3, slot4, on-slot-click }) ->
  div { class-name: "player-slots" },
    div { class-name: "team-red" },
      slot { id:1, player:slot1, on-slot-click }
      slot { id:2, player:slot2, on-slot-click }
    div { class-name: "field"},
      img { src: require "./field-img-white.png" }
    div { class-name: "team-blue" },
      slot { id:3, player:slot3, on-slot-click }
      slot { id:4, player:slot4, on-slot-click }


slot = ({ id, player, on-slot-click }) ->
  div { class-name: "slot" },
    if player
      img { src: player.image_url, on-click: -> on-slot-click "slot#{id}" }
    else
      id


map-state-to-props = ({ match-maker: { players, slot1, slot2, slot3, slot4 }}) ->
  { slot1, slot2, slot3, slot4 }


map-dispatch-to-props = (dispatch) ->
  { on-slot-click: (id) -> dispatch { type: \SLOT_FREE, id } }


module.exports = do
  slots |> connect map-state-to-props, map-dispatch-to-props

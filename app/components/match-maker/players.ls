React = require \react
{ connect } = require \react-redux
{ div, img } = React.DOM


player-chooser = ({ players, selected-players, on-player-click }) ->
  div { class-name: "players-to-choose" },
    players.map (player) ->
      class-name = "selectable-player" unless player in selected-players
      div { on-click: -> on-player-click player.id },
        img { src: player.image_url, class-name }


map-state-to-props = ({ match-maker: { players, slot1, slot2, slot3, slot4 }}) ->
  selected-players = [slot1, slot2, slot3, slot4].filter (x) -> x
  { players, selected-players }


map-dispatch-to-props = (dispatch) ->
  { on-player-click: (id) -> dispatch { type: \PLAYER_CHOOSE, id } }


module.exports = do
  connect map-state-to-props, map-dispatch-to-props
    <| player-chooser

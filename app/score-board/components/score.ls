{ connect } = require \react-redux
{ div, a, img } = (require \react).DOM


score-number = ({ goals }) ->
  div { class-name: "score-count" },
    div { id: "count-#{goals}"},
      [0 to 8].map (i) ->
        div {}, i


players = ({ players }) ->
  div { class-name: "team" },
    img { src:players[0].image_url, class-name: "player-icon" }
    img { src:players[1].image_url, class-name: "player-icon" }


team-score = ({ color, team, on-up-click, on-down-click }) ->
  div { class-name: "#{color}-side" },
    a { on-click: -> on-up-click color }, "+"
    score-number { goals: team.score }
    a { on-click: -> on-down-click color }, "-"
    players { players: team.players }


score = ({ red, blue, on-up-click, on-down-click }) ->
  div { class-name: "board" },
    team-score { team: red, color: "red", on-up-click, on-down-click  }
    div { class-name: "seperator" }
    team-score { team: blue, color: "blue", on-up-click, on-down-click  }


map-state-to-props = ({ score-board: { red, blue }}) ->
  { red, blue }


map-dispatch-to-props = (dispatch) ->
  on-up-click: (team) -> dispatch { type: \GOAL_UP, team }
  on-down-click: (team) -> dispatch { type: \GOAL_DOWN, team }


module.exports = do
  score |> connect map-state-to-props, map-dispatch-to-props

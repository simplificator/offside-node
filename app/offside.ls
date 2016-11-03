React = require \react
React-DOM = require \react-dom

Rx = require \rx
Rx-DOM = require \rx-dom

require "./style.scss"

{ h1, div, ul, li, img } = React.DOM


# ui components


player-chooser = ({ players }) ->
  if players
    ul { class-name: "player-chooser" },
      players.map (p) ->
        li {},
          img { src:p.image_url, id: p.id, class-name:"draggable" }
  else
    div {}, "loading players"


start-match-ui = ({ player1, player2, player3, player4 }) ->
  div { className: "start-match-ui" },
    div {},
      div { id: "player1", class-name: "player" },
        img { src:player1.image_url } if player1
      div { id: "player2", class-name: "player" },
        img { src:player2.image_url } if player2
    div {},
      div { id: "player3", class-name: "player" },
        img { src:player3.image_url } if player3
      div { id: "player4", class-name: "player" },
        img { src:player4.image_url } if player4


ui = ({ players, player1, player2, player3, player4 }) ->
  div {},
    h1 {}, "offside"
    start-match-ui { player1, player2, player3, player4 }
    player-chooser { players }


# rx stuff


game-state =
  players: []
  player1: undefined
  player2: undefined
  player3: undefined
  player4: undefined


update-state = (state, [action, params]) ->
  switch action
    case \get-players
      state.players = params
      state
    case \set-player
      [player_id, target] = params
      state[target] = state.players.find (p) -> p.id == +player_id
      state
    default state


mouse-down = Rx.Observable.from-event document.body, \mousedown
mouse-up = Rx.Observable.from-event document.body, \mouseup

set-player = mouse-down
  .filter (e) ->
    e.target.class-name == "draggable"
  .flat-map (down-e) ->
    mouse-up
      .take-until mouse-up
      .map (up-e) ->
        [down-e.target.id, up-e.target.id]
  .filter ([player, target]) ->
    target
  .map (params) ->
    [\set-player, params]


# render stuff


get-players = do
  Rx.DOM
    .ajax "/players"
    .map ({ response }) ->
      [\get-players, (JSON.parse response).filter (p) -> p.image_url]


Rx.Observable.merge [get-players, set-player]
  .scan update-state, game-state
  .do -> console.log arguments
  .subscribe (state) ->
    React-DOM.render (ui state), (document.get-element-by-id \offside)


# React-DOM.render (ui {}), (document.get-element-by-id \offside)

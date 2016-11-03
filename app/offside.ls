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


start-match-ui = ({ slot1, slot2, slot3, slot4 }) ->
  div { className: "start-match-ui" },
    div {},
      div { id: "slot1", class-name: "slot" },
        img { src:slot1.image_url } if slot1
      div { id: "slot2", class-name: "slot" },
        img { src:slot2.image_url } if slot2
    div {},
      div { id: "slot3", class-name: "slot" },
        img { src:slot3.image_url } if slot3
      div { id: "slot4", class-name: "slot" },
        img { src:slot4.image_url } if slot4


ui = ({ players, slot1, slot2, slot3, slot4 }) ->
  div {},
    h1 {}, "offside"
    start-match-ui { slot1, slot2, slot3, slot4 }
    player-chooser { players }


# rx stuff


game-state =
  players: []
  slot1: undefined
  slot2: undefined
  slot3: undefined
  slot4: undefined


update-state = (state, [action, params]) ->
  console.log action, params
  switch action
    case \get-players
      state.players = params
      state
    case \set-player
      [player, slot] = params
      state[slot.id] = state.players.find (p) -> p.id == +player.id
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
        slot = if up-e.target.class-name == "slot"
          up-e.target
        else
          up-e.target.parent-element

        [down-e.target, slot]
  .filter ([player, target]) ->
    target.class-name == "slot"
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
  .do -> console.table arguments
  .subscribe (state) ->
    React-DOM.render (ui state), (document.get-element-by-id \offside)

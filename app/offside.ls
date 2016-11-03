React = require \react
React-DOM = require \react-dom

Rx = require \rx
Rx-DOM = require \rx-dom

require "./style.scss"

{ h1, div, ul, li, img, a } = React.DOM


# ui components


ui = ({ players, slot1, slot2, slot3, slot4 }) ->
  div { class-name: "offside-main" },
    h1 {}, "choose players"
    start-match-ui { slot1, slot2, slot3, slot4 }
    game-buttons { slots: [slot1, slot2, slot3, slot4] }
    player-chooser { players, selected-players: [slot1, slot2, slot3, slot4] } if players?


start-match-ui = ({ slot1, slot2, slot3, slot4 }) ->
  div { class-name: "start-match-ui" },
    div { class-name: "blue" },
      player-slot { name:"slot1", player:slot1, number: 1 }
      player-slot { name:"slot2", player:slot2, number: 2 }
    div { class-name: "red" },
      player-slot { name:"slot3", player:slot3, number: 3 }
      player-slot { name:"slot4", player:slot4, number: 4 }


game-buttons = ({ slots }) ->
  class-name = "active" if (slots.filter (x) -> x).length == 4
  div { class-name: "game-buttons" },
    a { class-name }, "Start Game"
    a { class-name }, "Shuffle Teams"


player-chooser = ({ players, selected-players }) ->
  div { class-name: "player-chooser" },
    players.map (player) ->
      class-name = "selectable-player" unless player in selected-players
      div { class-name: "player" },
        player-icon { player, class-name }


player-icon = ({ player, class-name }) ->
  img { src:player.image_url, id: player.id, class-name: class-name }


player-slot = ({ name, player, number }) ->
  div { id: name, class-name: "slot" },
    if player
      player-icon { player, class-name: "selected-player" }
    else
      number



# rx stuff


game-state =
  players: []
  slot1: undefined
  slot2: undefined
  slot3: undefined
  slot4: undefined


update-state = (state, [action, params]) ->
  switch action
    case \get-players
      state.players = params
      state
    case \set-player
      player-id = params
      slot = find-available-slot state
      state[slot] = state.players.find (p) -> p.id == +player-id
      state
    case \free-slot
      slot-id = params
      state[slot-id] = undefined
      state
    default state



find-available-slot = (state) ->
  "slot" + [1 to 4].find (i) ->
    !state["slot#{i}"]


set-player = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.class-name == "selectable-player"
  .map (e) ->
    [\set-player, e.target.id]



free-slot = Rx.Observable
  .from-event document.body, \mousedown
  .filter (e) ->
    e.target.class-name == "selected-player"
  .map (e) ->
    [\free-slot, e.target.parent-element.id]



# render stuff


get-players = do
  Rx.DOM
    .ajax "/players"
    .map ({ response }) ->
      [\get-players, (JSON.parse response).filter (p) -> p.image_url]


Rx.Observable.merge [get-players, set-player, free-slot]
  .do (x) -> console.log x
  .scan update-state, game-state
  .subscribe (state) ->
    React-DOM.render (ui state), (document.get-element-by-id \offside)

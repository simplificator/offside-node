React = require \react
{ render } = require \react-dom
{ Provider } = require \react-redux

App = require "./components/main/ui.ls"
store = require "./store.ls"



ui = React.create-element Provider, { store: store }, App {}
render ui, document.get-element-by-id \offside


# TODO: refactor this
Rx = require \rx
Rx-DOM = require \rx-dom
Rx.DOM
  .ajax "/players"
  .subscribe ({ response }) ->
    store.dispatch do
      type: \PLAYERS_SET
      players: (JSON.parse response).filter (p) -> p.image_url

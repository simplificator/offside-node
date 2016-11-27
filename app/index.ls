{ create-store, apply-middleware } = require \redux
{ create-element } = require \react
{ render } = require \react-dom
{ Provider } = require \react-redux
{ create-epic-middleware } = require \redux-observable

App = require "./ui.ls"
reducer = require "./reducer.ls"
epic = require "./match-maker/epic.ls"

epic-middleware = create-epic-middleware epic
store = create-store reducer, apply-middleware epic-middleware
ui = create-element Provider, { store }, App {}


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

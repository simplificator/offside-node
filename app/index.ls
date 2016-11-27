{ create-store, apply-middleware } = require \redux
{ create-element } = require \react
{ render } = require \react-dom
{ Provider } = require \react-redux
{ create-epic-middleware } = require \redux-observable

ui = require "./ui.ls"
reducer = require "./reducer.ls"
epic = require "./match-maker/epic.ls"

epic-middleware = create-epic-middleware epic
store = create-store reducer, apply-middleware epic-middleware
app = create-element Provider, { store }, ui {}


render app, document.get-element-by-id \offside

store.dispatch { type: \FETCH_PLAYERS }

{ create-store, apply-middleware } = require \redux
{ create-element } = require \react
{ render } = require \react-dom
{ Provider } = require \react-redux
{ create-epic-middleware, combine-epics } = require \redux-observable

ui = require "./ui.ls"
reducer = require "./reducer.ls"

mm-epic = require "./match-maker/epic.ls"
sb-epic = require "./score-board/epic.ls"
epics = combine-epics mm-epic, sb-epic

epic-middleware = create-epic-middleware epics
store = create-store reducer, apply-middleware epic-middleware
app = create-element Provider, { store }, ui {}


render app, document.get-element-by-id \offside

store.dispatch { type: \FETCH_PLAYERS }

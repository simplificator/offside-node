React-DOM = require \react-dom
{ create-store, combine-reducers } = require \redux


match-maker = require "./components/match-maker/update-state.ls"
score-board = require "./components/score-board/update-state.ls"
main-component = require "./components/main/ui.ls"

store = require "./store.ls"

store.subscribe ->
  ui = main-component store.get-state!
  React-DOM.render ui, document.get-element-by-id \offside

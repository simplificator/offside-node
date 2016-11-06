React-DOM = require \react-dom

store = require "./store.ls"
main-component = require "./components/main/ui.ls"

store.subscribe ->
  ui = main-component store.get-state!
  React-DOM.render ui, document.get-element-by-id \offside

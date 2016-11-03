React = require \react
ReactDOM = require \react-dom

{ h1 } = React.DOM

ui = ->
  h1 {}, "this will be great"

ReactDOM.render (ui {}), document.body

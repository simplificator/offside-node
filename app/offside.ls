React = require \react
ReactDOM = require \react-dom
Rx = require \rx
RxDOM = require \rx-dom

{ h1, div, ul, li } = React.DOM

player-selector = ({ players }) ->
  if players
    ul {},
      players.map (p) ->
        li {}, p.name
  else
    div {}, "loading players"


ui = ({ players }) ->
  div {},
    h1 {}, "offside"
    div {},
      player-selector { players }


getPlayers = do
  Rx.DOM
    .ajax "/players"
    .subscribe ({ response }) ->
      players = JSON.parse response
      ReactDOM.render (ui { players }), (document.get-element-by-id \offside)


ReactDOM.render (ui {}), (document.get-element-by-id \offside)

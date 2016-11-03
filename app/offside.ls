React = require \react
ReactDOM = require \react-dom
Rx = require \rx
RxDOM = require \rx-dom

require "./style.scss"

{ h1, div, ul, li, img } = React.DOM

player-selector = ({ players }) ->
  if players
    ul { className: "player-chooser" },
      players.map (p) ->
        li {},
          div {},
            img { src:p.image_url }
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
      players = (JSON.parse response).filter (p) -> p.image_url
      ReactDOM.render (ui { players }), (document.get-element-by-id \offside)


ReactDOM.render (ui {}), (document.get-element-by-id \offside)

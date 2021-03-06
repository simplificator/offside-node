{ combine-reducers } = require \redux

match-maker = require "./match-maker/reducer.ls"
score-board = require "./score-board/reducer.ls"
sounds = require "./sounds/reducer.ls"

module.exports = combine-reducers {
  match-maker,
  score-board,
  sounds
}

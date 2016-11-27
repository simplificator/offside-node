{ create-store, combine-reducers } = require \redux

match-maker = require "./match-maker/reducer.ls"
score-board = require "./score-board/reducer.ls"

reducer = combine-reducers {
  match-maker,
  score-board
}

module.exports = create-store reducer

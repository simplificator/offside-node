{ create-store, combine-reducers } = require \redux

match-maker = require "./components/match-maker/update-state.ls"
score-board = require "./components/score-board/update-state.ls"

reducer = combine-reducers {
  match-maker,
  score-board
}

module.exports = create-store reducer

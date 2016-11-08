autoprefixer = require("autoprefixer")

module.exports = {
  entry: {
    "app/offside": "./app/offside.ls"
  },
  output: {
    path: __dirname,
    filename: "[name].js"
  },
  module: {
    loaders: [
      { test: /\.ls$/, loader: "livescript" },
      { test: /\.scss$/, loaders: ["style", "css", "postcss", "sass"] },
      { test: /\.(png|mp3)$/, loader: 'url-loader' }
    ]
  },
  postcss: [ autoprefixer({ browsers: ['last 4 versions'] }) ]
}

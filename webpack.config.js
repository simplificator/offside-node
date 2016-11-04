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
      { test: /\.(png|jpg|jpeg|gif|woff)$/, loader: 'url-loader' }
    ]
  },
  postcss: [ autoprefixer({ browsers: ['last 2 versions'] }) ]
}

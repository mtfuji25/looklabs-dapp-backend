const path = require('path');

module.exports = {
  entry: './src/index.js',
  watch: true,
  mode: "development",
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'public'),
  },
  module: {
    rules: [
      {
        test: /\.(png|jpe?g|gif)$/i,
        loader: 'file-loader',
        options: {
          name: './public/images/[name].[ext]',
        },
      },
    ],
  },
};
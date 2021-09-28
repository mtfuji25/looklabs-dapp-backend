const path = require('path');

module.exports = {
  entry: './src/index.js',
  watch: true,
  mode: "development",
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'public'),
  },
};
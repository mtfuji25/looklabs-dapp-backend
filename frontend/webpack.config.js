const path = require('path');

module.exports = {
  entry: './src/index.ts',

  // For development purpose only
  watch: true,
  mode: "development",
  // ! For development purpose only

  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  output: {
    filename: 'engine.js',
    path: path.resolve(__dirname, 'public'),
  },
};
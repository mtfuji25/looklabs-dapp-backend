const path = require("path");
const webpack = require("webpack");

module.exports = {
  entry: "./src/index.ts",
  plugins: [
    new webpack.EnvironmentPlugin({
      NODE_ENV: "development", // use 'development' unless process.env.NODE_ENV is defined
      DEBUG: false,
      WS_SERVER_HOST: "ws:localhost:8082",
    }),
  ],
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: "ts-loader",
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js"],
  },
  output: {
    filename: "engine.js",
    path: path.resolve(__dirname, "public"),
  },
};

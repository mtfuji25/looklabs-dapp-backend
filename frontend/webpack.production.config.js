const webpack = require("webpack");
const Dotenv = require("dotenv-webpack");
const { merge } = require("webpack-merge");
const common = require("./webpack.config.js");

// .env pick up from ghost file created in cloud run through ./config/set-env.js
// relative to ./frontend

module.exports = merge(common, {
    mode: "production",
    plugins: [new Dotenv({ path: "./.env" })]
});

const webpack = require("webpack");
const { merge } = require("webpack-merge");
const Dotenv = require("dotenv-webpack");
const common = require("./webpack.config.js");

module.exports = merge(common, {
    // For development purpose only
    watch: true,
    mode: "development",
    // ! For development purpose only
    plugins: [new Dotenv({ path: "../.env" })]
});

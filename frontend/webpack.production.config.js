const webpack = require("webpack");
const { merge } = require("webpack-merge");
const common = require("./webpack.config.js");

module.exports = merge(common, {
    mode: "production",
    plugins: [
        new webpack.EnvironmentPlugin({
            WS_SERVER_HOST: "wss://thepit-backend-3fiy6wgliq-nw.a.run.app"
        })
    ]
});

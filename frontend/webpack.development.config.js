const { merge } = require("webpack-merge");
const common = require("./webpack.config.js");

module.exports = merge(common, {
    // For development purpose only
    watch: true,
    mode: "development",
    // ! For development purpose only
    plugins: [
        new webpack.EnvironmentPlugin({
            WS_SERVER_HOST: "ws:localhost:8082"
        })
    ]
});

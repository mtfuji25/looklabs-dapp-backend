const webpack = require("webpack");
const { merge } = require("webpack-merge");
const common = require("./webpack.config.js");

module.exports = merge(common, {
    mode: "production",
    plugins: [
        new webpack.EnvironmentPlugin({
            WS_SERVER_HOST: "wss://thepit-backend-3fiy6wgliq-nw.a.run.app",
            // WS_SERVER_PORT: "",
            STRAPI_SERVER_HOST: "https://the-pit-cloud-3fiy6wgliq-nw.a.run.app/api/"
            // STRAPI_BEARER_TOKEN: ""
        })
    ]
});

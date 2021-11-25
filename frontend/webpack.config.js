const path = require("path");
const webpack = require("webpack");

module.exports = {
    entry: "./Source/Index.ts",
    plugins: [
        new webpack.EnvironmentPlugin({
            WS_SERVER_HOST: "ws:localhost:8082"
        })
    ],
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: "ts-loader",
/
            }
        ]
    },
    resolve: {
        extensions: [".tsx", ".ts", ".js"]
    },
    output: {
        filename: "engine.js",
        path: path.resolve(__dirname, "public")
    }
};

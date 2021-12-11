// "use strict";
// gcloud set env variables through arguments
const fs = require("fs");

const envVars = process.argv.slice(2).join("\n");
// const envPaths = process.env.ENV_PATH ? process.env.ENV_PATH.split(',') : [''];
const envPaths = ["./"];

envPaths.map((path) => {
    try {
        console.log("gcloudEnv.js: writing to path " + path);
        fs.writeFileSync(`${path}/.env`, envVars, { mode: 0o755 });
    } catch (err) {
        // An error occurred
        console.error(err);
    }
    console.log("gcloudEnv.js: .env set successfully");
});

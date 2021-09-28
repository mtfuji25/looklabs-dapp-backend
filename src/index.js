import { Application } from "@pixi/app";

const $ = (name) => {
    return document.querySelector(name);
}

const ROOT = $("#root");

const main = () => {
    
    // Create a PIXI application
    let app = new Application({
        resolution: devicePixelRatio,
        backgroundColor: 0xAAAAAA,
        resizeTo: ROOT
    });

    ROOT.appendChild(app.view);
}

// Call the main function and start the app.
main();
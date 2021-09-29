import * as PIXI from "pixi.js";

import { initInputs } from "./inputs/inputs";
import { initLayers } from "./layers";
import { initSystems } from "./ecs/systems";

import { gameLoop } from "./game-loop";

// Require the resources.json
import resource from "./resource.json";

const $ = (name) => {
    return document.querySelector(name);
}

const ROOT = $("#root");

// Current application
let app;

const main = () => {
    
    // Create a PIXI application
    app = new PIXI.Application({
        resolution: devicePixelRatio,
        backgroundColor: 0xAAAAAA,
        resizeTo: ROOT
    });

    // Append the base application to the root div of index.html
    ROOT.appendChild(app.view);

    // Make sure that the application is able to listen to events
    app.stage.interactive = true;

    // Start the event listeners and inti the input system
    initInputs(app);

    resource["packs"].forEach((pack) => {
        app.loader.add(resource[pack]);
    });

    app.loader.onComplete.add(() => {
        initGame(app);
    });
    app.loader.load();
}

const initGame = (app) => {

    // Connect the layers to the system
    initLayers(app);

    // Init all the systems
    initSystems();

    // Start the game loop
    app.ticker.add(gameLoop);
}

// Call the main function and start the app.
main();

export { app };
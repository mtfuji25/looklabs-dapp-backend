import { ECS_CORE } from "./ecs/core/ecs";
import { WS } from "./server/client";
import { layers } from "./layers";

// Base stats of application loop
const stats = {
    fps: 60.0,
    start: Date.now(),
    deltaTime: 1000.0 / 60.0,
};

//
// Main loop of application
//

const gameLoop = () => {
    // Calculates the delta time of the loop
    let current = Date.now();
    stats.deltaTime = (current - stats.start) / 1000.0;
    stats.start = current;
    stats.fps = 1 / stats.deltaTime;

    // Make render logic and requests
    ECS_CORE.update(stats.deltaTime);

    layers.forEach((layer) => {
        layer.onUpdate(stats.deltaTime);
    });
};

export { gameLoop, stats };
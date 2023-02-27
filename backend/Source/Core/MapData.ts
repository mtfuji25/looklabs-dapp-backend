// Map
import levelCollider from "../Assets/level_collider.json"; // XY sorted
import levelMap from "../Assets/level_map.json";
import levelOverlays from "../Assets/level_overlays.json";
import { Vec2 } from "../Utils/Math";
import SimplexNoise from "../Utils/SimplexNoise";

// True to generate a random map
const USE_RANDOM_MAP = false;

// True to generate squares in the map as obstacles
const USE_SQUARES = true;

// True to make the players spawn in random positions
// (Not working correctly, spawns the players in walls)
const USE_RANDOM_SPAWN_POS = true;

const randFn = Math.random;

if (USE_RANDOM_MAP) {
    const simplexNoise = new SimplexNoise(randFn);
    const depth = 20;
    const floorRate = 0.5;
    // Generates random map
    for (let x = 0; x < levelCollider.data.length; x++) {
        for (let y = 0; y < levelCollider.data[x].length; y++) {
            const n = simplexNoise.noise2d(x / depth, y / depth);

            if (n > floorRate) {
                // Puts wall
                levelCollider.data[x][y] = 1;
            } else {
                // Puts floor
                // levelCollider.data[x][y] = 0;
            }
        }
    }
}

if (USE_SQUARES) {
    // Puts squares in the map
    for (let x = 0; x < levelCollider.data.length; x++) {
        for (let y = 0; y < levelCollider.data[x].length; y++) {
            // levelCollider.data[y][x] = 0;
            if (x % 8 === 0 && y % 8 === 0) {
                levelCollider.data[x][y] = 1;
                levelCollider.data[x][y + 1] = 1;
                levelCollider.data[x][y + 2] = 1;
                levelCollider.data[x][y + 3] = 1;

                levelCollider.data[x + 1][y] = 1;
                levelCollider.data[x + 1][y + 1] = 1;
                levelCollider.data[x + 1][y + 2] = 1;
                levelCollider.data[x + 1][y + 3] = 1;

                if (levelCollider.data[x - 1]) {
                    levelCollider.data[x - 1][y + 1] = 1;
                    levelCollider.data[x - 1][y + 2] = 1;
                }
                if (levelCollider.data[x + 2]) {
                    levelCollider.data[x + 2][y + 1] = 1;
                    levelCollider.data[x + 2][y + 2] = 1;
                }
            }
        }
    }
}

/**
 * Returns a position to spawn where there is floor
 */
const getSpawnCell = (matrix = levelCollider.data): Vec2 => {
    let x, y;
    do {
        x = Math.floor(randFn() * matrix.length);
        y = Math.floor(randFn() * matrix[0].length);
        // it must not be on a collider
    } while (matrix[x][y] !== 0);

    const cell = new Vec2(x, y);

    console.log("spawn cell", x, y, "is", matrix[x][y]);

    return cell;
};

export { levelCollider, levelMap, levelOverlays, getSpawnCell, USE_RANDOM_SPAWN_POS };

// Map
import levelCollider from "../Assets/level_collider.json";
import levelMap from "../Assets/level_map.json";
import levelOverlays from "../Assets/level_overlays.json";
import { GridUtils } from "../Utils/GridUtils";
import { Vec2 } from "../Utils/Math";
import { Grid } from "./Ecs/Components/Grid";
import SimplexNoise from "../Utils/SimplexNoise";
import spawnPos from "../Assets/SpawnPositions.json";
import { PlayerLayer } from "../Layers/Lobby/Player";

const USE_RANDOM_MAP = false; // True to generate a random map
const USE_SQUARES = false; // True to generate squares in the map as obstacles
const USE_RANDOM_SPAWN_POS = false; // True to make the players spawn in random positions

const randFn = Math.random;

if (USE_RANDOM_MAP) {
    const simplexNoise = new SimplexNoise(randFn);
    const depth = 20;
    const floorRate = 0.3;
    // Generates random map
    for (let y = 0; y < levelCollider.data.length; y++) {
        for (let x = 0; x < levelCollider.data[y].length; x++) {
            const n = simplexNoise.noise2d(x / depth, y / depth);
            levelCollider.data[y][x] = n > floorRate ? 1 : 0;
        }
    }
}

if (USE_SQUARES) {
    // Puts squares in the map
    for (let y = 0; y < levelCollider.data.length; y++) {
        for (let x = 0; x < levelCollider.data[y].length; x++) {
            //levelCollider.data[y][x] = 0;
            if (x % 4 === 0 && y % 4 === 0) levelCollider.data[y][x] = 1;
        }
    }
}

/**
 * Returns a position to spawn where there is floor
 */
const getSpawnPos = (grid: Grid) => {
    if (!USE_RANDOM_SPAWN_POS) {
        return {
            x: spawnPos.pos[PlayerLayer.playerCount % spawnPos.pos.length].x,
            y: spawnPos.pos[PlayerLayer.playerCount % spawnPos.pos.length].y
        };
    }

    let x, y;
    do {
        x = Math.floor(randFn() * levelCollider.data[0].length);
        y = Math.floor(randFn() * levelCollider.data.length);
        // it must not be on a collider
    } while (levelCollider.data[y][x]);

    const pos = GridUtils.convertCellToPos(new Vec2(x, y), grid);

    return { x: pos.x, y: pos.y };
};

export { levelCollider, levelMap, levelOverlays, getSpawnPos };

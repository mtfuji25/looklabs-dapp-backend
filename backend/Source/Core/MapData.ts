// Map
import levelCollider from "../Assets/level_collider.json";
import levelMap from "../Assets/level_map.json";
import levelOverlays from "../Assets/level_overlays.json";
import { GridUtils } from "../Utils/GridUtils";
import { Vec2 } from "../Utils/Math";
import SimplexNoise from "../Utils/SimplexNoise";
import { Grid } from "./Ecs/Components/Grid";

const randFn = Math.random;
const simplexNoise = new SimplexNoise(randFn);
const depth = 20;
const floorRate = 0.25;
const statueCollider = {
    from: {x: 47, y: 47},
    to: {x: 70, y: 70}
}

levelCollider.data.forEach((dy: number[], y: number) => {
    dy.forEach((dx: number, x: number) => {
        const n = simplexNoise.noise2d(x / depth, y / depth);

        levelCollider.data[y][x] = n > floorRate ? 1 : 0;
    });
});

for (let i = statueCollider.from.y; i <= statueCollider.to.y; i++) {
    for (let j = statueCollider.from.x; j <= statueCollider.to.x; j++) {
        levelCollider.data[i][j] = 2;
    }
}

/**
 * Returns a position to spawn where there is floor
 */
const getSpawnPos = (grid: Grid) => {
    let x, y, cell;
    do {
        // Number between -1 and 1
        x = randFn() * 2 - 1;
        y = randFn() * 2 - 1;

        cell = GridUtils.convertPosToCell(
            GridUtils.convertFromNDC(new Vec2(x, y)
        ), grid);
        
        // Y must be between -0.5 to 0.5 and it must not be on a collider
    } while (y > 0.5 || y < -0.5 || levelCollider.data[cell.x][cell.y]);

    return { x, y };
};

export { levelCollider, levelMap, levelOverlays, getSpawnPos };

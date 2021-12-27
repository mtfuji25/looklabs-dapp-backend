// Map importing
import { AStarFinder } from "astar-typescript";
import levelCollider from "../Assets/level_collider.json";
import { Grid } from "../Core/Ecs/Components/Grid";
import { Vec2 } from "./Math";


const transposedCollider: Array<Array<number>> = [];
for (let i = 0; i < levelCollider["height"]; ++i) {
    const row: number[] = [];
    for (let j = 0; j < levelCollider["width"]; ++j) {
        const collider = levelCollider["data"][j][i];
        row.push(collider);
    }
    transposedCollider.push(row);
}


class GridUtils {

    static finder = new AStarFinder({
        grid: {
            matrix: transposedCollider
        },
        diagonalAllowed: false,
        includeStartNode: true,
        includeEndNode: true
    });

    static convertFromNDC  (pos: Vec2): Vec2  {
        const position = pos.adds(1.0).divs(2.0);
        position.y = 1 - position.y;

        return position;
    }

    static convertToNDC (pos: Vec2): Vec2 {
        const position = new Vec2(
            pos.x,
            0 - pos.y
        );

        return position;
    }

    static convertCellToPos (cell: Vec2, grid: Grid): Vec2{
        const position = new Vec2(
            (cell.x * grid.intervalX / 2.0) - (grid.intervalX / 4.0),
            (cell.y * grid.intervalY / 2.0) - (grid.intervalY / 4.0)
        );

        return position;
    }

    static convertPosToCell  (pos: Vec2, grid: Grid): Vec2 {
        const index = new Vec2(
            Math.floor(pos.x / (grid.intervalX / 2.0)),
            Math.floor(pos.y / (grid.intervalY / 2.0)),
        );

        return index;
    }

    
}

export {GridUtils}
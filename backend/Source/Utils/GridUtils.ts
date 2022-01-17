// Map importing
import { AStarFinder } from "../Utils/astar/astar";
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

    static finder:AStarFinder = new AStarFinder({
        grid: {
            matrix: transposedCollider
        },
        diagonalAllowed: false,
        includeStartNode: true,
        includeEndNode: true
    });
    

    static getCellWalkable (row:number,column:number):number {
        if (row < 0 || column < 0) return 1;
        if (transposedCollider.length <= row) return 1;
        if (transposedCollider[row].length <= column) return 1;
        return transposedCollider[row][column];
    }

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

    static getValidCell (x:number, y:number):Vec2 | null {
        if (x >= 0 && y >= 0 && x < levelCollider["width"] && y < levelCollider["height"]) {
            return new Vec2(x, y);
        }
        return null;
    }

    static getNeighborsAtDistance  (origin:Vec2, distance:number):Vec2[] {

        
        const result:Vec2[] = [];
        
         // collect top row
         result.push(this.getValidCell(origin.x-distance,origin.y));
         for (const i in [...Array<number>(distance)].keys()) {
             const index = Number(i);
             result.push(this.getValidCell(origin.x-distance,origin.y-(index+1)));
             result.push(this.getValidCell(origin.x-distance,origin.y+(index+1)));
         }
             
         // collect bottom row
         result.push(this.getValidCell(origin.x+distance,origin.y))
         for (const i in [...Array<number>(distance)].keys()) {
             const index = Number(i);
             result.push(this.getValidCell(origin.x+distance,origin.y-(index+1)));
             result.push(this.getValidCell(origin.x+distance,origin.y+(index+1)));
         }
         // collect left row
         result.push(new Vec2(origin.x,origin.y-distance))
         for (const i in [...Array<number>(distance-1)].keys()) {
             const index = Number(i);
             result.push(this.getValidCell(origin.x-(index+1),origin.y-distance));
             result.push(this.getValidCell(origin.x+(index+1),origin.y-distance));
         }
     
         // collect right row
         result.push(this.getValidCell(origin.x,origin.y+distance))
         for (const i in [...Array<number>(distance-1)].keys()) {
             const index = Number(i);
             result.push(this.getValidCell(origin.x-(index+1),origin.y+distance));
             result.push(this.getValidCell(origin.x+(index+1),origin.y+distance));
         }
     
    
        // // collect top row
        // result.push(grid[origin.x-distance][origin.y]);
        // for (const i in [...Array<number>(distance)].keys()) {
        //     const index = Number(i);
        //     result.push(grid[origin.x-distance][origin.y-(index+1)]);
        //     result.push(grid[origin.x-distance][origin.y+(index+1)]);
        // }
            
        // // collect bottom row
        // result.push(grid[origin.x+distance][origin.y])
        // for (const i in [...Array<number>(distance)].keys()) {
        //     const index = Number(i);
        //     result.push(grid[origin.x+distance][origin.y-(index+1)]);
        //     result.push(grid[origin.x+distance][origin.y+(index+1)]);
        // }
        // // collect left row
        // result.push(grid[origin.x][origin.y-distance])
        // for (const i in [...Array<number>(distance-1)].keys()) {
        //     const index = Number(i);
        //     result.push(grid[origin.x-(index+1)][origin.y-distance]);
        //     result.push(grid[origin.x+(index+1)][origin.y-distance]);
        // }
    
        // // collect right row
        // result.push(grid[origin.x][origin.y+distance])
        // for (const i in [...Array<number>(distance-1)].keys()) {
        //     const index = Number(i);
        //     result.push(grid[origin.x-(index+1)][origin.y+distance]);
        //     result.push(grid[origin.x+(index+1)][origin.y+distance]);
        // }
    
        return result;
    }

    // static isColliding (ocupations:Vec2[]):boolean {
    //     if (GridUtils.getCellWalkable(ocupations[0].y, ocupations[0].x) == 1 || 
    //         GridUtils.getCellWalkable(ocupations[0].y - 1, ocupations[0].x) == 1) return true ;
            

    //     // down: ocupations[3] ocupations[4] ocupations[5]
    //     if (GridUtils.getCellWalkable(ocupations[4].y, ocupations[4].x) == 1 ||
    //         GridUtils.getCellWalkable(ocupations[4].y + 1, ocupations[4].x) == 1) return true;
            

    //     // left: ocupations[0] ocupations[2] ocupations[3]
    //     if (GridUtils.getCellWalkable(ocupations[2].y, ocupations[2].x) == 1 ||
    //         GridUtils.getCellWalkable(ocupations[2].y, ocupations[2].x - 1) == 1) return true;
            

    //     // right: ocupations[5] ocupations[6] ocupations[7]
    //     if (GridUtils.getCellWalkable(ocupations[6].y, ocupations[6].x) == 1 ||
    //         GridUtils.getCellWalkable(ocupations[2].y, ocupations[2].x + 1) == 1) return true;

        
    //     return false;
    // }


    // static getEscapeVector (ocupations:Vec2[]):Vec2 {
        
    //     // up: ocupations[1] ocupations[0] ocupations[8]
    //     const upCollision:boolean = 
    //         GridUtils.getCellWalkable(ocupations[0].y, ocupations[0].x) == 1 || 
    //         GridUtils.getCellWalkable(ocupations[0].y - 1, ocupations[0].x) == 1 ;
            

    //     // down: ocupations[3] ocupations[4] ocupations[5]
    //     const downCollision:boolean = 
    //         GridUtils.getCellWalkable(ocupations[4].y, ocupations[4].x) == 1 ||
    //         GridUtils.getCellWalkable(ocupations[4].y + 1, ocupations[4].x) == 1;
            

    //     // left: ocupations[0] ocupations[2] ocupations[3]
    //     const leftCollision:boolean = 
    //         GridUtils.getCellWalkable(ocupations[2].y, ocupations[2].x) == 1 ||
    //         GridUtils.getCellWalkable(ocupations[2].y, ocupations[2].x - 1) == 1;
            

    //     // right: ocupations[5] ocupations[6] ocupations[7]
    //     const rightCollision:boolean = 
    //         GridUtils.getCellWalkable(ocupations[6].y, ocupations[6].x) == 1 ||
    //         GridUtils.getCellWalkable(ocupations[2].y, ocupations[2].x + 1) == 1;
            

    //     // find escape vector
    //     if (upCollision && leftCollision) return new Vec2(0.7,-0.7);
    //     if (upCollision && rightCollision) return new Vec2(-0.7,-0.7);
    //     if (downCollision && leftCollision) return new Vec2(0.7,0.7);
    //     if (downCollision && rightCollision) return new Vec2(-0.7,0.7);
    //     if (leftCollision) return new Vec2(1,0);
    //     if (rightCollision) return new Vec2(-1,0);
    //     if (upCollision ) return new Vec2(0,-1);
    //     if (downCollision) return new Vec2(0,1);
    //     return null;
    // }
    
}

export {GridUtils}
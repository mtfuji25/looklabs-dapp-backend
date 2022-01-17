// Import ECS
import { ECS } from "../Core/Ecs";

// Import systems
import { sys_UpdatePos } from "./Rigidbody";
import { sys_CheckCollisions, sys_UpdateGrid } from "./Grid";
import { sys_DipatchDeaths, sys_UpdateStatus } from "./Status";
import { sys_CheckForBerserker, sys_CheckInRange, sys_UpdateBehavior } from "./Behavior";
import { sys_UpdateCollisions } from "./Grid";
import { sys_CheckOverlap } from "./Aabb";
import { EcsData } from "../Interfaces";
import { Vec2 } from "../../../Utils/Math";
import { GridUtils } from "../../../Utils/GridUtils";
import { Grid } from "../Components/Grid";
let num = 0;
const startSystems = (ecs: ECS) => {
    // Update all status components
    ecs.pushContainerSystem(sys_UpdateStatus);

    // Dispatch all deaths
    ecs.pushContainerSystem(sys_DipatchDeaths);

    // Update dynamic index of grid entities
    ecs.pushContainerSystem(sys_UpdateGrid);

    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(sys_CheckCollisions);
    
    // Update Behavior requirements
    ecs.pushContainerSystem(sys_CheckForBerserker);

    // Update Behavior requirements
    ecs.pushContainerSystem(sys_CheckInRange);

    // Update Behavior tree
    ecs.pushContainerSystem(sys_UpdateBehavior);

    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(sys_UpdateCollisions);

    // Update all components position
    ecs.pushContainerSystem(sys_UpdatePos);

    // Update all components position
    ecs.pushContainerSystem(sys_CheckOverlap);

    // A temporary fix to invalid positions
    /*
    So far, this only affects one cell in the grid { x: 9, y: 34 }
    At the top left corner of the map where there's an odd corner
    */
    ecs.pushContainerSystem(sys_CheckIndex);
};


const sys_CheckIndex = (data: EcsData, deltaTime: number): void => {
    
    data.rigidbodys.forEach((rigidbody) => {
        let transform = rigidbody.rectangle.transform;

        if (transform) {
            
            const position = transform.pos.adds(1.0).divs(2.0);
            position.y = 1 - position.y;
    
            // Find new index of entity
            const index = new Vec2(
                Math.floor(position.x / (data.grids[0].intervalX / 2.0)),
                Math.floor(position.y / (data.grids[0].intervalY / 2.0)),
            );
            
            if (GridUtils.getCellWalkable(index.y, index.x) == 1) {                
                const grid = data.grids[0];

                const newIndex = getNewIndex(index);
                if (newIndex) {
                    const newPosition = new Vec2(
                        (newIndex.x * grid.intervalX + grid.intervalX / 2.0) - 1.0,
                        1.0 - (newIndex.y * grid.intervalY + grid.intervalY / 2.0)
                    );
                    console.log("Fixing Invalid Position", num,  newPosition, index);
                    rigidbody.rectangle.transform.pos = newPosition;
                    
                }
                num++;
                
            }
        }
    });
}

const getNewIndex = (index:Vec2):Vec2 | null => {
        
        let d = 1
        let result:Vec2[] = []
        //setting max distance to 5, no point looking for neighbors farther away than that
        while (result.length == 0 && d < 6) {
            const neighbors = GridUtils.getNeighborsAtDistance (index, d);
            result = neighbors.filter ( p => {
                if (p) {
                    if (GridUtils.getCellWalkable(p.y, p.x) == 0) {
                        return p;
                    }
                }
            });
            d++;
        }
        if (result.length == 0) return null;
        let shortestDist = Number.MAX_SAFE_INTEGER;
        let closestIndex = 0;
        result.forEach ( (cell, i) => {
            const dist = index.sub(
                cell
            ).squareLength();
            if (dist < shortestDist) {
                closestIndex = i;
                shortestDist = dist;
            }
        });
        return result[closestIndex];
}


export { startSystems };
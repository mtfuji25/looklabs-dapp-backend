import { GridUtils } from "../../../Utils/GridUtils";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { Entity } from "../Core/Ecs";

const MIN_DISTANCE = 0.01;

const strategy_moveOnPath = (entity:Entity, grid:Grid, target?:Entity):void => {

    if (entity.getBehavior().colliding.length > 0) {
        entity.getStrategy().pathData = null;
        return;
    }

    const pos = entity.getTransform().pos;
    // move along path
    const pathData = entity.getStrategy().pathData;
    if (pathData && pathData.path) {
        let target = GridUtils.convertCellToPos( pathData.path[pathData.pathIndex], grid);
        
        if (_closeEnough(target, pos, MIN_DISTANCE)) {
            // pick next target
            let nextIndex = pathData.pathIndex++;
            
            if (nextIndex == pathData.path.length) {
                // end of path
                // clear!
                console.log("CLEAR PATH");
                entity.getStrategy().pathData = null;
                return;
            } else {
                pathData.pathIndex = nextIndex;
                target =  GridUtils.convertCellToPos (pathData.path[pathData.pathIndex], grid);  
            }
        } 
        
        // move towards target
        const rigidbody = entity.getRigidbody();
        const status = entity.getStatus();
        rigidbody.velocity = target.sub(pos).normalize().muls(status.speed);
    } else {
        entity.getStrategy().pathData = null;
    }
}


const _closeEnough = (pos1:Vec2, pos2:Vec2, minDistance:number):boolean => {
    const dist = pos1.sub(
        pos2
    ).length();

    // console.log(dist);
    return dist <= minDistance;
}

export { strategy_moveOnPath }
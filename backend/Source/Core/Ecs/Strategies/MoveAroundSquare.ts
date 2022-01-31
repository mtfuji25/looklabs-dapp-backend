
import { Vec2 } from "../../../Utils/Math";
import { DynamicEntity, Grid } from "../Components/Grid";
import { Entity } from "../Core/Ecs";
import { entitiesAlive } from "../Systems/Behavior";

const ringPath = [
    new Vec2(-0.1983,0.2155),
    new Vec2(-0.2500,0.0948),
    new Vec2(-0.3534,0.0431),
    new Vec2(-0.3534,-0.1121),
    new Vec2(-0.2500,-0.1638),
    new Vec2(-0.1983,-0.2845),
    new Vec2(0.2328,-0.2845),
    new Vec2(0.2845,-0.1638),
    new Vec2(0.3879,-0.1121),
    new Vec2(0.3879,0.0431),
    new Vec2(0.2845,0.0948),
    new Vec2(0.2328,0.2155),
	
];

const quadrants = [
    [new Vec2(40,57),new Vec2(48,49)],//top left and bottom right
    [new Vec2(40,70),new Vec2(48,62)],
    [new Vec2(69,57),new Vec2(77,49)],
    [new Vec2(69,70),new Vec2(77,62)],

];

const finalFighters:DynamicEntity[] = [];
let stuck:boolean = false;
let stuckTimer:number = 0;
// let strategyTimer:number = 0;

const strategy_MoveAroundSquare = (entity:Entity, grid:Grid, target?:Entity):void => {
    
    if (!stuck) return;
    
    // if players are close enough to each other...
    // let the normal strategies take over at this point
    if (_closeEnough(finalFighters[0].entity.getTransform().pos, finalFighters[1].entity.getTransform().pos, 0.1)) {
        stuck = false;
        return;
    }

    const pos = entity.getTransform().pos;
    // move along path
    const path = entity.getStrategy().pathData;
    if (path) {
        let target = ringPath[path.pathIndex];
        
        if (_closeEnough(target, pos, 0.01)) {
            // entity.getTransform().setPos(target.x, target.y);        
            // pick next target
            let nextIndex = path.pathIndex + path.direction;
            if (nextIndex < 0) nextIndex = ringPath.length - 1;
            if (nextIndex == ringPath.length) nextIndex = 0;
            path.pathIndex = nextIndex;
            target = ringPath[path.pathIndex];  
        } 

        // move towards target
        const rigidbody = entity.getRigidbody();
        const status = entity.getStatus();
        rigidbody.velocity = target.sub(pos).normalize().muls(status.speed);
    }    
    
}

const finalPlayersAreStuck = (dynamic:DynamicEntity):boolean => {
   
    if (entitiesAlive > 2) {
        return false;
    }

    // check if we have to reset everything
    if (entitiesAlive == 1 && finalFighters.length > 0) {
        _resetFinalFight();
        return false;
    }

    //if we already ran the checks and players are stuck, move on
    if (stuck) return true;
    
    // wait until we have both final players
    if (finalFighters.length < 2) {
        if (dynamic.entity.getStatus().health > 0)
            finalFighters.push(dynamic);
        return false;
    }
    
    // check if both players are in the danger zones
    if (!_isIndexWithinQuadrant(finalFighters[0].index)) return false;
    if (!_isIndexWithinQuadrant(finalFighters[1].index)) return false;

    // check if they're not on the same quadrant
    if (_stuckTogether(finalFighters[0].index, finalFighters[1].index)) return false;

    //wait here for 20 seconds 
    if (stuckTimer == 0) {
        stuckTimer = Date.now();
        return false;
    } else {
        const timeNow = Date.now();
        const timer = timeNow - stuckTimer;
        if (timer < 20000) {
            return false;
        }
    }
    


    stuck = true;

    // create path objects for players
    const pathPoint1 = _closestPathPointToPos(finalFighters[0].entity.getTransform().pos);
    const pathPoint2 = _closestPathPointToPos(finalFighters[1].entity.getTransform().pos);
    
    // make sure players move in opposite directions on the path
    let player1Dir = finalFighters[0].index.x > 58 ? -1 : 1;
    if (finalFighters[0].index.x < 58 && finalFighters[1].index.x < 58) {
        player1Dir = finalFighters[0].index.y < finalFighters[1].index.y ? 1 : -1;
    } else if (finalFighters[0].index.x > 58 && finalFighters[1].index.x > 58) {
        player1Dir = finalFighters[0].index.y < finalFighters[1].index.y ? -1 : 1;
    }
    const player2Dir = player1Dir * -1;
    
    finalFighters[0].entity.getStrategy().pathData = {
        entity: finalFighters[0].entity,
        pathIndex: pathPoint1,
        direction: player1Dir,
    }; 

    finalFighters[1].entity.getStrategy().pathData = {
        entity: finalFighters[1].entity,
        pathIndex: pathPoint2,
        direction: player2Dir,
    }; 

    return true;
}

const _isIndexWithinQuadrant = (index:Vec2):boolean => {
    let result = false;
	quadrants.forEach (q => {
        if (index.x >= q[0].x && index.x <= q[1].x && index.y <= q[0].y && index.y >= q[1].y) {
            result = true;
            return;
        }        
    });
    return result;
}

const _stuckTogether = (index1:Vec2, index2:Vec2):boolean => {
    let q1 = -1;
    let q2 = -1;
    quadrants.forEach ((q, i) => {
        if (q1 < 0 && index1.x >= q[0].x && index1.x <= q[1].x && index1.y <= q[0].y && index1.y >= q[1].y) {
            q1 = i;
    
        }
        if (q2 < 0 && index2.x >= q[0].x && index2.x <= q[1].x && index2.y <= q[0].y && index2.y >= q[1].y) {
            q2 = i;
        }        
    });
    
    return q1 == q2;
}

const _closestPathPointToPos = (pos:Vec2):number => {
    let shortestDist = Number.MAX_SAFE_INTEGER;
    let closestIndex = 0;
    ringPath.forEach ( (p, i) => {
        const dist = p.sub(
            pos
        ).length();
        if (dist < shortestDist) {
            closestIndex = i;
            shortestDist = dist;
        }
    });
    return closestIndex;
}


const _resetFinalFight = ():void => {
    finalFighters.splice(0,finalFighters.length);
    stuckTimer = 0;
    stuck = false;
}

const _closeEnough = (pos1:Vec2, pos2:Vec2, minDistance:number):boolean => {
    const dist = pos1.sub(
        pos2
    ).length();

    // console.log(dist);
    return dist <= minDistance;
}

export {strategy_MoveAroundSquare, finalPlayersAreStuck};
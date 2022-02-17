import { Vec2 } from "../../../Utils/Math";
import { DynamicEntity, Grid } from "../Components/Grid";
import { Entity } from "../Core/Ecs";
import { entitiesAlive } from "../Systems/Behavior";
import { strategy_Explore } from "./Explore";

type DangerZone = {
    quadrant:Vec2[];
    target:Vec2
};

const MAX_TIME_STUCK = 30000;


const dangerZones:DangerZone[] = [
    { quadrant: [new Vec2(104,74), new Vec2(99,79)], target: new Vec2(0.4741,-0.3190)},
    { quadrant: [new Vec2(108,82), new Vec2(99,88)], target: new Vec2(0.4741,-0.4569)},
    { quadrant: [new Vec2(114,67), new Vec2(99,72),], target: new Vec2(0.7155,-0.0948)},
    { quadrant: [new Vec2(105,72), new Vec2(91,82)], target: new Vec2(0.5086,-0.3190)},
    { quadrant: [new Vec2(114,32), new Vec2(82,41)], target: new Vec2(0.2845,0.3362)},
    { quadrant: [new Vec2(114,42), new Vec2(82,49)], target: new Vec2(0.3362,0.1983)},
    { quadrant: [new Vec2(114,50), new Vec2(83,55)], target: new Vec2(0.6638,-0.0259)},
    { quadrant: [new Vec2(114,65), new Vec2(91,69)], target:  new Vec2(0.5431,-0.0603)},
    { quadrant: [new Vec2(114,72), new Vec2(91,72)], target:  new Vec2(0.6466,-0.3190),},
    { quadrant: [new Vec2(113,76), new Vec2(105,80)], target:  new Vec2(0.8879,-0.0776)},
    { quadrant: [new Vec2(51,32), new Vec2(45,39),], target: new Vec2(-0.1466,0.2500)},
    { quadrant: [new Vec2(71,32), new Vec2(63,39),], target: new Vec2(0.2845,0.2672)},
    { quadrant: [new Vec2(72,78), new Vec2(65,89),], target: new Vec2(0.3362,-0.4397)},
    { quadrant: [new Vec2(36,42), new Vec2(1,49),], target: new Vec2(-0.6466,0.0431)},
    { quadrant: [new Vec2(36,32), new Vec2(1,41)], target: new Vec2(-0.2500,0.3707)},
    { quadrant: [new Vec2(51,78), new Vec2(45,89)], target: new Vec2(-0.2500,-0.4224)},
    { quadrant: [new Vec2(35,74),  new Vec2(1,79)], target: new Vec2(-0.6638,-0.1983)},
    { quadrant: [new Vec2(36,80), new Vec2(1,87)], target: new Vec2(-0.2155,-0.4569)},
    { quadrant: [new Vec2(78,49), new Vec2(69,57)], target: new Vec2(0.2328,0.2845)},
    { quadrant: [new Vec2(78,62), new Vec2(69,70)], target: new Vec2(0.2155,-0.3362)},
    { quadrant: [new Vec2(47,48), new Vec2(39,57)], target: new Vec2(-0.2155,0.2672)},
    { quadrant: [new Vec2(48,62), new Vec2(39,71)], target: new Vec2(-0.1983,-0.3190)}
];

const strategy_Unstuck = (entity:Entity, grid:Grid, target?:Entity):void => {

    const strategy = entity.getStrategy();
    const rigibody = entity.getRigidbody();
    const behavior = entity.getBehavior();

    const dz = strategy.dangerZone;

    if (dz) {
        const pos = entity.getTransform().pos;
        
        if (_closeEnough(dz.target, pos, 0.01)) {
            strategy.dangerZone = null;
            strategy.stuckStartTime = 0;
            strategy_Explore(entity, grid);
        } else {
            // move towards target
            const rigidbody = entity.getRigidbody();
            const status = entity.getStatus();
            rigidbody.velocity = dz.target.sub(pos).normalize().muls(status.speed);
        }
    }
}

const isPlayerStuck = (dynamic:DynamicEntity):boolean => {
    
    if (entitiesAlive > 20) return false;
    const strategy = dynamic.entity.getStrategy();

    // if player is colliding with another player, disregard
    if (dynamic.entity.getBehavior().colliding.length > 0 ) {
        strategy.stuckStartTime = 0;
        strategy.dangerZone = null;
        return false;
    }

    // if player is already stuck, check to see if it's the same spot
    if (strategy.dangerZone) {
        if (!_isIndexWithinQuadrant (dynamic.index, strategy.dangerZone.quadrant)) {
            strategy.stuckStartTime = 0;
            strategy.dangerZone = null;
            return false;
        } 
    } else {
        strategy.stuckStartTime = 0;

        for (var i = 0; i < dangerZones.length; i++) {
            const dz = dangerZones[i];
            if (_isIndexWithinQuadrant (dynamic.index, dz.quadrant)) {
                strategy.dangerZone = dz;
                strategy.stuckStartTime = Date.now();
                break;
            }
        }
        if (!strategy.dangerZone) return false;
    }

    if (strategy.stuckStartTime == 0 || Date.now() - strategy.stuckStartTime < MAX_TIME_STUCK) {
        return false;
    }
    
    return true;
}

const _isIndexWithinQuadrant = (index:Vec2, quadrant:Vec2[]):boolean => {
    if (index.x <= quadrant[0].x && index.x >= quadrant[1].x && index.y >= quadrant[0].y && index.y <= quadrant[1].y) {
        return true;
    }   
	return false;
}

const _closeEnough = (pos1:Vec2, pos2:Vec2, minDistance:number):boolean => {
    const dist = pos1.sub(
        pos2
    ).length();

    // console.log(dist);
    return dist <= minDistance;
}

export { DangerZone, strategy_Unstuck, isPlayerStuck}
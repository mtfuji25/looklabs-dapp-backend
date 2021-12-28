import assert from "assert";
import { Vec2 } from "../../../Utils/Math";
import { DynamicEntity, Grid } from "../Components/Grid";
import { Entity } from "../Core/Ecs";
import { Behavior } from "../Components/Behavior";
import { GridUtils } from "../../../Utils/GridUtils";
import { strategy_Explore } from "./Explore";
import { entitiesAlive } from "../Systems/Behavior";
import { Strategy } from "../Components/Strategy";

const strategy_Seek = (entity:Entity, grid:Grid, target?:Entity):void => {
    const behavior = entity.getBehavior();

    if (behavior.staticCollide) {
        _seekNearestInRangeWithA(entity, grid);
        behavior.staticCollide = false;
    } else {
        // console.log("Entered Searching inRange node");                    
        if (entitiesAlive <= 5 || Math.random() > 0.8) {//the higher the value here, the longer the game
            _seekNearestInRange(entity, grid);
        } else {
            // switch behavior to EXPLORE
            strategy_Explore(entity, grid);
        }
    }
}

const strategy_SeekNearest = (entity:Entity, grid:Grid, target?:Entity):void => {
    const behavior = entity.getBehavior();

    if (behavior.staticCollide) {
        // console.log("Entered Searching outRange node with A*");
        _seekNearestWithA(entity, grid, target);
        behavior.staticCollide = false;
    } else {
        // console.log("Entered Searching outRange node");
        _seekNearest(entity, grid, target);
    }
}

const _seekNearest = (entity:Entity, grid:Grid, target?:Entity) => {
    
    let nearest:Entity =  _getNearest(entity, target);
    
    if (!nearest) {
        _seekNearestInRange(entity, grid);
        return;
    }
        
    _seekTarget(nearest, entity, grid);
}

const _seekNearestInRange = (entity:Entity, grid:Grid) => {

    let nearest: Entity = _getNearestInRange(entity);

    if (!nearest) {
        strategy_Explore(entity, grid);
        return;
    }
        
    _seekTarget(nearest, entity, grid);

}

const _seekTarget = (target:Entity, entity:Entity, grid:Grid):void => {

    const status = entity.getStatus();

    const transform = entity.getTransform();
    const rigidbody = entity.getRigidbody();
    const enemy = target.getTransform();

    if (!enemy.pos.equal(transform.pos)) {
        rigidbody.velocity = enemy.pos.sub(transform.pos).normalize().muls(status.speed);
        assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 5: ${rigidbody} Is NaN`);
    }
}

const _seekNearestWithA = (entity: Entity, grid: Grid, target?:Entity) => {
    
    
    let nearest:Entity =  _getNearest(entity, target);
    
    if (!nearest) 
        return;
    
    const behavior = entity.getBehavior();
    const rigidbody = entity.getRigidbody();
    
    const other = grid.getDynamic(nearest);
    const dynamic = grid.getDynamic(entity);

    // Sources and direction vectors
    const sources: Vec2[] = _getFinderOrigins(behavior, dynamic, grid);
    let dir: Vec2 | null = _getFinderDirection(entity, sources, other.index, grid);

    rigidbody.velocity = dir;
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 4: ${rigidbody} Is NaN, dir was ${dir}`);

}

const _seekNearestInRangeWithA = (entity: Entity, grid: Grid) => {

    const rigidbody = entity.getRigidbody();
    const behavior = entity.getBehavior();

    let nearest: Entity = _getNearestInRange(entity);

    if (!nearest) {
        return;
    }

    const other = grid.getDynamic(nearest);
    const dynamic = grid.getDynamic(entity);

    // Sources and direction vectors
    const sources: Vec2[] =  _getFinderOrigins(behavior, dynamic, grid);
    let dir: Vec2 | null = _getFinderDirection(entity, sources, other.index, grid);;
    rigidbody.velocity = dir;
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 7: ${rigidbody} Is NaN, dir was ${dir}`);
}

const _getNearest  = (entity:Entity, target?:Entity) => {
    const status = entity.getStatus();
    const priorities = entity.getStrategy().getTierPriority();

    let nearest:Entity =  target ? target : entity.getBehavior().nearest;
    if ((status.tier == "sigma" || status.tier == "alpha")  && entitiesAlive > 5 ) {
        const priorityTarget = Strategy.pickNearestTarget(entity, priorities);
        if (priorityTarget !== null) nearest = priorityTarget;
    }
    return nearest;

}

const _getNearestInRange = (entity:Entity) => {
    const rigidbody = entity.getRigidbody();
    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const status = entity.getStatus();
    const priorities = entity.getStrategy().getTierPriority();

    let targets:Entity[] = [...behavior.inRange];

    if ((status.tier == "sigma" || status.tier == "alpha") && entitiesAlive > 5) {
        const priorityTargets = Strategy.pickTargetsInRange(entity, priorities);
        if (priorityTargets.length > 0) targets = priorityTargets;
    }

    let nearest: Entity;
    let shortestDist = Number.MAX_SAFE_INTEGER;

    targets.map((other) => {
        const dist = transform.pos.sub(
            other.getTransform().pos
        ).squareLength();

        if (dist < shortestDist) {
            nearest = other;
            shortestDist = dist;
        }
    });
    return nearest;
}

const _getFinderOrigins = (behavior:Behavior, dynamic:DynamicEntity, grid:Grid):Vec2[] => {
    const sources: Vec2[] = [];
    
    behavior.staticCenter.map((center) => {
        const convertedCenter = GridUtils.convertPosToCell(GridUtils.convertFromNDC(center), grid);
        dynamic.ocupations.map((ocupation) => {
            const diff = convertedCenter.abs(ocupation);
            // Checks if is axis aligned neighbor
            if ((diff.x == 0 && diff.y == 1) || (diff.x == 1 && diff.y == 0)) {
                sources.push(ocupation);
            }
        });
    });
    return sources;
}

const _getFinderDirection = (entity:Entity, sources:Vec2[], destinationIndex:Vec2, grid:Grid):Vec2 => {
    let dir: Vec2 | null = null;
    sources.map((source, index) => {
        if (!dir)
            dir = new Vec2();

        const path = GridUtils.finder.findPath(
            source, destinationIndex
        );

        if (path === null || path.length < 2) {
            // console.log("Source of null path: ", source)
            // console.log("Source of null path: ", other.index)
            return;
        }

        const dest = GridUtils.convertCellToPos(new Vec2(path[1][0], path[1][1]), grid);
        const origin = GridUtils.convertCellToPos(new Vec2(path[0][0], path[0][1]), grid);

        if (!dest.equal(origin)){
            dir = dir.add(dest.sub(origin));
            // assert(!(isNaN(dir.x) || isNaN(dir.y)), `Behavior 41: ${rigidbody} Is NaN`);
        }
    });

    const nearest = entity.getBehavior().nearest;
    const speed = entity.getStatus().speed;
    const pos = entity.getTransform().pos;

    if (dir && (!dir.equal(new Vec2(0, 0)))) {
        dir = GridUtils.convertToNDC(dir).normalize().muls(speed);
        // assert(!(isNaN(dir.x) || isNaN(dir.y)), `Behavior 42: ${rigidbody} Is NaN`);
    } else {
        const enemyPos = nearest.getTransform().pos;
        if (!enemyPos.equal(pos)) {
            dir = enemyPos.sub(pos).normalize().muls(speed);
            // assert(!(isNaN(dir.x) || isNaN(dir.y)), `Behavior 43: ${rigidbody} Is NaN`);
        }
    }
    return dir;
}

export { strategy_Seek, strategy_SeekNearest }
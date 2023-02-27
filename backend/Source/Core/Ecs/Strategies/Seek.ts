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

    // Added to debug
    return _seekNearestInRangeWithA(entity, grid);

    if (behavior.staticCollide) {
        _seekNearestInRangeWithA(entity, grid);
        behavior.staticCollide = false;
    } else {
        if (entitiesAlive < 6 || Math.random() > 0.7) {//the higher the value here, the longer the game            
            _seekNearestInRange(entity, grid, entitiesAlive > 20);
        } else {
            strategy_Explore(entity, grid);
        }
    }
}

const strategy_SeekNearest = (entity:Entity, grid:Grid, target?:Entity):void => {
    const behavior = entity.getBehavior();

    // Added to debug
    return _seekNearestWithA(entity, grid, target);

    if (behavior.staticCollide) {
        // When the entity collide with a wall, it'll use the path finder
        _seekNearestWithA(entity, grid, target);
        behavior.staticCollide = false;
    } else {
        _seekNearest(entity, grid, target);
    }
}

const _seekNearest = (entity:Entity, grid:Grid, target?:Entity) => {

    let nearest:Entity =  _getNearest(entity, target);
    
    if (!nearest) {
        if (entity.getBehavior().inRange.length > 0) {
            _seekNearestInRange(entity, grid);
        } else {
            strategy_Explore(entity, grid);
        }
        return;
    }
        
    _seekTarget(nearest, entity, grid);
}

const _seekNearestInRange = (entity:Entity, grid:Grid, prioritize:boolean = false) => {
    
    let nearest: Entity = prioritize ? _getNearestInTierRange(entity) : _getNearestInRange(entity);

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
    } else {
        strategy_Explore(entity, grid);
    }
}

const _seekNearestWithA = (entity: Entity, grid: Grid, target?:Entity) => {
    
    let nearest:Entity =  _getNearest(entity, target);
    
    if (!nearest) {
        if (entity.getBehavior().inRange.length > 0) {
            _seekNearestInRangeWithA(entity, grid);
        } else {
            strategy_Explore(entity, grid);
        }
        return;
    }
        
    
    const behavior = entity.getBehavior();
    const rigidbody = entity.getRigidbody();
    
    const other = grid.getDynamic(nearest);
    const dynamic = grid.getDynamic(entity);
    
    // Sources and direction vectors
    const sources: Vec2[] = _getPathFinderOrigins(behavior, dynamic, grid);
    let dir: Vec2 | null = _getPathFinderDirection(entity, sources, other.index, grid);

    // Added to debug
    // console.log("Dir:", dir)

    if (!dir) {
        rigidbody.velocity = _unstuck(dynamic);
    } else {
        // Added to debug
        // const currentPos = entity.getTransform().pos;
        // const currentCell = GridUtils.convertPosToCell(GridUtils.convertFromNDC(currentPos), grid);
        // console.log("currentCell", currentCell.x, "/", currentCell.y);
        // const nextPos = dir.add(currentPos);
        // const nextCell = GridUtils.convertPosToCell(GridUtils.convertFromNDC(nextPos), grid);
        // console.log("nextCell", nextCell.x, "/", nextCell.y);
        rigidbody.velocity = dir;
    }
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 4: ${rigidbody} Is NaN, dir was ${dir}`);
}

const _seekNearestInRangeWithA = (entity: Entity, grid: Grid, prioritize:boolean = false) => {
    
    const rigidbody = entity.getRigidbody();
    const behavior = entity.getBehavior();
    
    let nearest: Entity = prioritize ? _getNearestInTierRange(entity) : _getNearestInRange(entity);

    if (!nearest) {
        if (prioritize) {
            strategy_Explore(entity, grid);
        } else {
            _seekNearestInRangeWithA(entity, grid, true);
        }
        return;
    }

    const other = grid.getDynamic(nearest);
    const dynamic = grid.getDynamic(entity);

    // Sources and direction vectors
    const sources: Vec2[] =  _getPathFinderOrigins(behavior, dynamic, grid);
    let destination = other.index;
    if (GridUtils.getCellWalkable(other.index.y, other.index.x) == 1) {
        other.ocupations.forEach( o => {
            if (GridUtils.getCellWalkable(o.y, o.x) == 0) {
                destination = o;
                return;
            }
        });
    }

    let dir: Vec2 | null = _getPathFinderDirection(entity, sources, destination, grid);
    
    if (!dir) {
        rigidbody.velocity = _unstuck(dynamic);
        
    } else {
        rigidbody.velocity = dir;
    }
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

    const behavior = entity.getBehavior();
    const transform = entity.getTransform();

    let targets:Entity[] = [...behavior.inRange];
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

const _getNearestInTierRange = (entity:Entity) => {

    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const priorities = entity.getStrategy().getTierPriority();

    let targets:Entity[] = [...behavior.inRange];

    const priorityTargets = Strategy.pickTargetsInRange(entity, priorities);
    if (priorityTargets.length > 0) targets = priorityTargets;
    
    if (targets.length == 0) {
        //add all tiers in range
        targets = [ ...behavior.inRangeByTier['sigma'], ...behavior.inRangeByTier['alpha'], ...behavior.inRangeByTier['beta'], ...behavior.inRangeByTier['delta']];
        return targets[Math.floor(Math.random() * targets.length)];
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

const _getPathFinderOrigins = (behavior:Behavior, dynamic:DynamicEntity, grid:Grid):Vec2[] => {
    const sources: Vec2[] = [];
    if (behavior.staticCenter.length == 0) {
        sources.push(dynamic.index);
    } else {
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
    }
    
    return sources;
}

const _getPathFinderDirection = (entity:Entity, sources:Vec2[], destinationIndex:Vec2, grid:Grid):Vec2 => {
    let dir: Vec2 | null = null;
    sources = sources.filter( s => GridUtils.getCellWalkable(s.y, s.x) == 0);
    sources.map((source, index) => {
        if (!dir)
            dir = new Vec2();
        
        const path = GridUtils.finder.findPath(
            source, destinationIndex
        );

        if (!path || path.length < 2) {
            return;
        }

        entity.getStrategy().pathData = (
        {   entity : entity,
            pathIndex : 0,
            direction : 1,
            path : GridUtils.convertPathToVec2(path)
        }
        );

        // Changed to "fromArray", works in the same way
        // const origin = GridUtils.convertCellToPos(new Vec2(path[0][0], path[0][1]), grid);
        // const dest = GridUtils.convertCellToPos(new Vec2(path[1][0], path[1][1]), grid);
        const origin = GridUtils.convertCellToPos(Vec2.fromArray(path[0]), grid);
        const dest = GridUtils.convertCellToPos(Vec2.fromArray(path[1]), grid);

        if (!dest.equal(origin)){
            dir = dir.add(dest.sub(origin));
            // assert(!(isNaN(dir.x) || isNaN(dir.y)), `Behavior 41: ${rigidbody} Is NaN`);
        }    
        
    });

    const speed = entity.getStatus().speed;
    
    if (dir && (!dir.equal(new Vec2(0, 0)))) {
        // If it's not converted to NDC the sprites 
        // will move away from each other on the Y axis.
        // dir = GridUtils.convertToNDC(dir).normalize().muls(speed);

        // Check this, before it was using the commented version of convertToNDC.
        // It was put invertY instead.
        dir = GridUtils.invertY(dir).normalize().muls(speed);
        return dir;
    }

    return null;
}

const escapePoints:Vec2[] = [  new Vec2(-0.3707,0.2155), new Vec2(-0.3707,-0.2845), new Vec2(0.3879,-0.2845), new Vec2(0.3879,0.2155)]

const _unstuck = (dynamic:DynamicEntity):Vec2 => {
    
    const status = dynamic.entity.getStatus();
    const nearest = dynamic.entity.getBehavior().nearest;
    if (entitiesAlive > 20 && nearest) {        
        const transform = dynamic.entity.getTransform();
        const enemyPos = nearest.getTransform().pos;
        
        if (!enemyPos.equal(transform.pos)) {
            return enemyPos.sub(transform.pos).normalize().muls(status.speed);
        }
    } 

    const transform = dynamic.entity.getTransform();
    // get nearest point in escapePoints
    let nearestPoint: Vec2;
    let shortestDist = Number.MAX_SAFE_INTEGER;
    escapePoints.map((pos) => {
        const dist = transform.pos.sub(
            pos
        ).squareLength();

        if (dist < shortestDist) {
            nearestPoint = pos;
            shortestDist = dist;
        }
    });
    return nearestPoint.sub(transform.pos).normalize().muls(status.speed);

    
}

export { strategy_Seek, strategy_SeekNearest }
import assert from "assert";
import { Vec2 } from "../../../Utils/Math";
import { DynamicEntity, Grid } from "../Components/Grid";
import { Entity } from "../Core/Ecs";
import { AStarFinder } from "astar-typescript";
import { Behavior } from "../Components/Behavior";
import { Rigidbody } from "../Components/Rigidbody";
import { GridUtils } from "../../../Utils/GridUtils";
import { strategy_Explore } from "./Explore";
import { entitiesAlive } from "../Systems/Behavior";


const strategy_Seek = (entity:Entity, grid:Grid, deltaTime: number):void => {
    const behavior = entity.getBehavior();

    if (behavior.staticCollide) {
        // console.log("Entered Searching inRange node with A*");
        _seekNearestInRangeWithA(entity, grid);
        behavior.staticCollide = false;
    } else {
        // console.log("Entered Searching inRange node");                    
        if (entitiesAlive <= 5 || Math.random() > 0.8) {//the higher the value here, the longer the game
            _seekNearestInRange(entity);
        } else {
            // switch behavior to EXPLORE
            strategy_Explore(entity, grid, deltaTime);
        }
    }
}

const strategy_SeekNearest = (entity:Entity, grid:Grid, deltaTime: number):void => {
    const behavior = entity.getBehavior();

    if (behavior.staticCollide) {
        // console.log("Entered Searching outRange node with A*");
        _seekNearestWithA(entity, grid);
        behavior.staticCollide = false;
    } else {
        // console.log("Entered Searching outRange node");
        _seekNearest(entity);
    }
}


const _seekNearest = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    const target = behavior.nearest;

    if (!target)
        return;
    
    const enemy = target.getTransform();

    if (!enemy.pos.equal(transform.pos)) {
        rigidbody.velocity = enemy.pos.sub(transform.pos).normalize().muls(status.speed);
        assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 5: ${rigidbody} Is NaN`);
    }

    // behavior.attacking = false;
}

const _seekNearestInRange = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    let nearest: Entity;
    let shortestDist = Number.MAX_SAFE_INTEGER;

    behavior.inRange.map((other) => {
        const dist = transform.pos.sub(
            other.getTransform().pos
        ).length();

        if (dist < shortestDist) {
            nearest = other;
            shortestDist = dist;
        }
    });

    if (!nearest)
        return;

    const enemy = nearest.getTransform();
    
    if (!enemy.pos.equal(transform.pos)) {
        rigidbody.velocity = enemy.pos.sub(transform.pos).normalize().muls(status.speed);
        assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 5: ${rigidbody} Is NaN`);
    }

    // behavior.attacking = false;
}

const _seekNearestWithA = (entity: Entity, grid: Grid) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    const nearest = behavior.nearest;
    
    if (!nearest)
        return;
    
    const other = grid.getDynamic(nearest);
    const dynamic = grid.getDynamic(entity);


    // Sources and direction vectors
    const sources: Vec2[] = _getFinderOrigins(behavior, dynamic, grid);
    let dir: Vec2 | null = _getFinderDirection(entity, sources, other.index, grid);

    rigidbody.velocity = dir;
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 4: ${rigidbody} Is NaN, dir was ${dir}`);

    // behavior.attacking = false;
}

const _seekNearestInRangeWithA = (entity: Entity, grid: Grid) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    let nearest: Entity;
    let shortestDist = Number.MAX_SAFE_INTEGER;

    behavior.inRange.map((other) => {
        const dist = transform.pos.sub(
            other.getTransform().pos
        ).length();

        if (dist < shortestDist) {
            nearest = other;
            shortestDist = dist;
        }
    });

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
    // behavior.attacking = false;
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
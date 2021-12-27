import assert from "assert";
import { Vec2 } from "../../../Utils/Math";
import { Behavior } from "../Components/Behavior";
import { Grid } from "../Components/Grid";
import { Entity } from "../Core/Ecs";
import { entitiesAlive } from "../Systems/Behavior";
import { strategy_Explore } from "./Explore";

const strategy_Flee = (entity:Entity, grid:Grid, deltaTime: number):void => {

    const behavior = entity.getBehavior();
    
    if (behavior.attacking) {
        // console.log("Decided RunAway from current target");
        _runAwayFromTarget(entity, grid);
    } else if (behavior.inRange.length > 0) {
        // console.log("Decided RunAway from relative range enemies");
        _runAwayFromRange(entity, grid);
    } else {
        // console.log("Decided RunAway from all enemies");
        if (Math.random() > 0.5 && entitiesAlive > 2) {
            _runAwayFromAll(entity, grid);
        } else {
            // switch behavior to EXPLORE
            strategy_Explore(entity, grid, deltaTime);
        }
        
    }   
}

const _runAwayFromTarget = (entity: Entity, grid: Grid) => {

    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const tranform = entity.getTransform();
    const rigidbody = entity.getRigidbody();
    const target = behavior.target ?? null;

    // switch to from all
    if (!target) {
        _runAwayFromRange(entity, grid);
        return;
    }

    const enemy = target.getTransform();
    
    let runAwayDir = new Vec2();

    if (behavior.staticCollide) {
        runAwayDir = _solveWall (enemy.pos, tranform.pos, behavior);
        
    } else {
        runAwayDir = tranform.pos.sub(enemy.pos).normalize();
    }

    rigidbody.velocity = runAwayDir.normalize().muls(status.speed);
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 1: ${rigidbody} Is NaN`);

    // behavior.attacking = false;
        
}

const _runAwayFromRange = (entity: Entity, grid: Grid) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const tranform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    const range = behavior.inRange;

    if (behavior.inRange.length == 0) {
        _runAwayFromAll(entity, grid);
        return;
    }

    let relativeEnemy = new Vec2();

    range.map((enemy) => {
        const { pos } = enemy.getTransform();
        relativeEnemy = relativeEnemy.add(pos);
    });

    let runAwayDir = new Vec2();

    if (behavior.staticCollide) {
        runAwayDir = _solveWall (relativeEnemy, tranform.pos, behavior);
    } else {
        runAwayDir = tranform.pos.sub(relativeEnemy).normalize();
    }

    rigidbody.velocity= runAwayDir.normalize().muls(status.speed);
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 2: ${rigidbody} Is NaN`);

    // behavior.attacking = false;
}

const _runAwayFromAll = (entity: Entity, grid: Grid) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const tranform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    let relativeEnemy = new Vec2();

    grid.dynamics.map((enemy) => {
        const { pos } = enemy.entity.getTransform();
        relativeEnemy = relativeEnemy.add(pos);
    })

    let runAwayDir = new Vec2();

    if (behavior.staticCollide) {
        runAwayDir = _solveWall (relativeEnemy, tranform.pos, behavior);
    } else {
        runAwayDir = tranform.pos.sub(relativeEnemy).normalize();
    }

    rigidbody.velocity= runAwayDir.normalize().muls(status.speed);
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 3: ${rigidbody} Is NaN`);

    // behavior.attacking = false;
}

const _solveWall = (enemyPosition:Vec2, entityPosition:Vec2, behavior:Behavior):Vec2 => {
    let escapeVector = new Vec2();
    let resNormal = new Vec2();

    behavior.staticNormal.map((normal) => {
        resNormal = resNormal.add(normal);
    });

    // Performs suffle operation
    const tempX = resNormal.x;
    resNormal.x = resNormal.y;
    resNormal.y = tempX;

    if (Math.abs(resNormal.x) === Math.abs(resNormal.y)) {
        escapeVector = resNormal.muls(-1.0);

        const relativeEnemyPos = enemyPosition.sub(entityPosition);

        if (Math.abs(relativeEnemyPos.x) === Math.abs(relativeEnemyPos.y)) {
            if (Math.random() < 0.5) {
                escapeVector.x = 0.0;
            } else {
                escapeVector.y = 0.0;
            }
        } else if (Math.abs(relativeEnemyPos.x) < Math.abs(relativeEnemyPos.y)) {
            escapeVector.y = 0.0;
        } else {
            escapeVector.x = 0.0;
        }

    } else if (Math.abs(resNormal.x) < Math.abs(resNormal.y)) {
        const relativeEnemyPos = enemyPosition.sub(entityPosition);

        if (relativeEnemyPos.y < 0) {
            escapeVector.x = 0.0;
            escapeVector.y = 1.0;
        } else {
            escapeVector.x = 0.0;
            escapeVector.y = -1.0;
        }
    } else {
        const relativeEnemyPos = enemyPosition.sub(entityPosition);

        if (relativeEnemyPos.x < 0) {
            escapeVector.x = 1.0;
            escapeVector.y = 0.0;
        } else {
            escapeVector.x = -1.0;
            escapeVector.y = 0.0;
        }
    }
    return escapeVector;
}

export { strategy_Flee }



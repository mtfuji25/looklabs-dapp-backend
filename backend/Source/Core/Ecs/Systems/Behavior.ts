import { Vec2 } from "../../../Utils/Math";
import { Entity } from "../Core/Ecs";
import { EcsData } from "../Interfaces";

// AStar import
import { AStarFinder } from "astar-typescript";

// Map importing
import levelCollider from "../../../Assets/LevelCollider.json";
import { Grid } from "../Components/Grid";

const finder = new AStarFinder({
    grid: {
        matrix: levelCollider["data"]
    },
    diagonalAllowed: false,
    includeStartNode: true,
    includeEndNode: true
});

const ENTITY_RANGE = 0.1;

const runAwayFromTarget = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const tranform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    const target = behavior.target ?? null;

    if (!target)
        return;

    const enemy = target.getTransform();
    
    const runAwayDir = tranform.pos.sub(enemy.pos).normalize();
    
    rigidbody.velocity = runAwayDir.muls(status.speed);

    behavior.attacking = false;
}

const runAwayFromRange = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const tranform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    const range = behavior.inRange;

    let relativeEnemy = new Vec2();

    range.map((enemy) => {
        const { pos } = enemy.getTransform();

        relativeEnemy = relativeEnemy.add(pos);
    });

    const runAwayDir = tranform.pos.sub(relativeEnemy).normalize();

    rigidbody.velocity= runAwayDir.muls(status.speed);

    behavior.attacking = false;
}

const hitTarget = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();

    let enemy = behavior.colliding[0];

    if (!enemy)
        return;

    // Checks if is able to hit other enemy
    if (behavior.refresh >= status.cooldown) {
        const enemyStatus = enemy.getStatus();

        enemyStatus.hit(entity);

        behavior.target = enemy;
        behavior.attacking = true;
        behavior.refresh = 0.0;
    } else {
        behavior.attacking = false;
    }
}

const hitStrongest = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();

    // Sort based on attack
    behavior.colliding.sort((a, b) => {
        const attackA = a.getStatus().attack;
        const attackB = b.getStatus().attack;
        if (attackA > attackB)
            return -1;
        if (attackA < attackB)
            return 1;
        return 0;
    });

    // Get strongest enemy
    const enemy = behavior.colliding[0];

    // Checks if is able to hit other enemy
    if (behavior.refresh >= status.cooldown) {

        const enemyStatus = enemy.getStatus();

        enemyStatus.hit(entity);

        behavior.target = enemy;
        behavior.attacking = true;
        behavior.refresh = 0.0;
    } else {
        behavior.attacking = false;
    }
}

const seekNearestWithA = (entity: Entity, grid: Grid) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    const nearest = behavior.nearest;
    
    if (!nearest)
        return;
    
    const other = grid.getDynamic(nearest);
    const dynamic = grid.getDynamic(entity);

    // Começo do solver

    console.log("Entity: ", dynamic.index);
    console.log("Hunting: ", other.index);

    const convertFromNDC = (pos: Vec2): Vec2 => {
        const position = pos.adds(1.0).divs(2.0);
        position.y = 1 - position.y;

        return position;
    };

    const convertToNDC = (pos: Vec2): Vec2 => {
        const position = new Vec2(
            pos.x,
            0 - pos.y
        );

        return position;
    };

    const convertCellToPos = (cell: Vec2): Vec2 => {
        const position = new Vec2(
            (cell.x * grid.intervalX / 2.0) - (grid.intervalX / 4.0),
            (cell.y * grid.intervalY / 2.0) - (grid.intervalY / 4.0)
        );

        return position;
    };

    const convertPosToCell = (pos: Vec2): Vec2 => {
        const index = new Vec2(
            Math.floor(pos.x / (grid.intervalX / 2.0)),
            Math.floor(pos.y / (grid.intervalY / 2.0)),
        );

        return index;
    };

    // Sources and direction vectors
    const sources: Vec2[] = [];
    let dir: Vec2 | null = null;

    console.log("Static Centers: ", behavior.staticCenter)
    console.log("Ocupations: ", dynamic.ocupations)
    behavior.staticCenter.map((center) => {
        const convertedCenter = convertPosToCell(convertFromNDC(center));
        console.log("Static Cell: ", convertedCenter)
        dynamic.ocupations.map((ocupation) => {
            const diff = convertedCenter.abs(ocupation);

            // Checks if is axis aligned neighbor
            if ((diff.x == 0 && diff.y == 1) || (diff.x == 1 && diff.y == 0)) {
                sources.push(ocupation);
            }
        });
    });

    console.log("Sources: ", sources);

    sources.map((source, index) => {
        if (!dir)
            dir = new Vec2();

        const path = finder.findPath(
            source, other.index
        );
        console.log("Path" + index, path)

        const dest = convertCellToPos(new Vec2(path[1][0], path[1][1]));
        const origin = convertCellToPos(new Vec2(path[0][0], path[0][1]));

        console.log("Dest" + index, dest);
        console.log("Origin" + index, origin);

        if (!dest.equal(origin)){
            console.log("SubDir" + index, dest.sub(origin));
            dir = dir.add(dest.sub(origin));
        }
    });
    console.log("PreDir: ", dir);
    if (dir) {
        dir = convertToNDC(dir).normalize().muls(status.speed);
        console.log("FinalDir: ", dir);
    } else {
        const enemyPos = nearest.getTransform().pos;
        if (!enemyPos.equal(transform.pos)) {
            dir = enemyPos.sub(transform.pos).normalize().muls(status.speed);
        }
    }

    rigidbody.velocity = dir;

    behavior.attacking = false;
}

const seekNearestInRangeWithA = (entity: Entity, grid: Grid) => {
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

    const other = grid.getDynamic(nearest);
    const dynamic = grid.getDynamic(entity);

    // Começo do solver

    console.log("Entity: ", dynamic.index);
    console.log("Hunting: ", other.index);

    const convertFromNDC = (pos: Vec2): Vec2 => {
        const position = pos.adds(1.0).divs(2.0);
        position.y = 1 - position.y;

        return position;
    };

    const convertToNDC = (pos: Vec2): Vec2 => {
        const position = new Vec2(
            pos.x,
            0 - pos.y
        );

        return position;
    };

    const convertCellToPos = (cell: Vec2): Vec2 => {
        const position = new Vec2(
            (cell.x * grid.intervalX / 2.0) - (grid.intervalX / 4.0),
            (cell.y * grid.intervalY / 2.0) - (grid.intervalY / 4.0)
        );

        return position;
    };

    const convertPosToCell = (pos: Vec2): Vec2 => {
        const index = new Vec2(
            Math.floor(pos.x / (grid.intervalX / 2.0)),
            Math.floor(pos.y / (grid.intervalY / 2.0)),
        );

        return index;
    };

    // Sources and direction vectors
    const sources: Vec2[] = [];
    let dir: Vec2 | null = null;

    console.log("Static Centers: ", behavior.staticCenter)
    console.log("Ocupations: ", dynamic.ocupations)
    behavior.staticCenter.map((center) => {
        const convertedCenter = convertPosToCell(convertFromNDC(center));
        console.log("Static Cell: ", convertedCenter)
        dynamic.ocupations.map((ocupation) => {
            const diff = convertedCenter.abs(ocupation);

            // Checks if is axis aligned neighbor
            if ((diff.x == 0 && diff.y == 1) || (diff.x == 1 && diff.y == 0)) {
                sources.push(ocupation);
            }
        });
    });

    console.log("Sources: ", sources);

    sources.map((source, index) => {
        if (!dir)
            dir = new Vec2();

        const path = finder.findPath(
            source, other.index
        );
        console.log("Path" + index, path)

        const dest = convertCellToPos(new Vec2(path[1][0], path[1][1]));
        const origin = convertCellToPos(new Vec2(path[0][0], path[0][1]));

        console.log("Dest" + index, dest);
        console.log("Origin" + index, origin);

        if (!dest.equal(origin)){
            console.log("SubDir" + index, dest.sub(origin));
            dir = dir.add(dest.sub(origin));
        }
    });
    console.log("PreDir: ", dir);
    if (dir) {
        dir = convertToNDC(dir).normalize().muls(status.speed);
        console.log("FinalDir: ", dir);
    } else {
        const enemyPos = nearest.getTransform().pos;
        if (!enemyPos.equal(transform.pos)) {
            dir = enemyPos.sub(transform.pos).normalize().muls(status.speed);
        }
    }

    rigidbody.velocity = dir;

    behavior.attacking = false;
}

const seekNearest = (entity: Entity) => {
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
    }

    behavior.attacking = false;
}

const seekNearestInRange = (entity: Entity) => {
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
    }

    behavior.attacking = false;
}

const sys_CheckInRange = (data: EcsData, deltaTime: number): void => {
    data.grids.map((grid) => {

        // Clear last inRange check
        grid.dynamics.map((dynamic) => {
            const behavior = dynamic.entity.getBehavior();

            behavior.inRange = [];
            behavior.nearest = null;
        })

        for (let i = 0; i < grid.dynamics.length; ++i) {
            // Get current entity
            const entity = grid.dynamics[i].entity;

            // Get its components
            const behavior = entity.getBehavior();
            const transform = entity.getTransform();

            // Init max int to sort distances
            let shortestDist = Number.MAX_SAFE_INTEGER;

            // For any other non checked entity
            for (let j = i + 1; j < grid.dynamics.length; ++j) {
                // Get other entity
                const other = grid.dynamics[j].entity;

                if (entity.destroyed || other.destroyed)
                        return;

                // Get other entity tranform
                const otherBehavior = other.getBehavior();
                const otherTransform = other.getTransform();

                if (!otherBehavior)
                    return;

                if (!otherTransform)
                    return;

                // Calculates the dist to other entity
                const dist = transform.pos.sub(
                    otherTransform.pos
                ).length();

                // If other entity is in range add to array
                if (dist <= ENTITY_RANGE) {
                    behavior.inRange.push(other);
                    otherBehavior.inRange.push(entity);
                }

                // If other entity is the nearest
                if (dist < shortestDist) {
                    behavior.nearest = other;
                    shortestDist = dist;
                }

                if (!otherBehavior.nearest)
                    otherBehavior.nearest = entity;

                // Checks if other entity nearest will change
                const otherShortestDist = otherTransform.pos.sub(
                    otherBehavior.nearest.getTransform().pos
                ).length();

                if (dist < otherShortestDist) {
                    otherBehavior.nearest = entity;
                }
            }
        }
    });
}

const sys_UpdateBehavior = (data: EcsData, deltaTime: number): void => {
    
    data.grids.map((grid) => {
        grid.dynamics.map((dynamic) => {
            
            const entity = dynamic.entity;

            // Get current player components
            const status = entity.getStatus();
            const behavior = entity.getBehavior();

            // Get current life percent of player
            const lifePercent = (status.health / status.maxHealth) * 100;

            // Update cooldown
            behavior.refresh += deltaTime;

            // Healing checks
            if (lifePercent >= 40) {
                behavior.healing = false;
            }

            if (lifePercent < 100) {
                status.health += 0.01
            }

            // Life check
            if (lifePercent < 25 || behavior.healing) {
                console.log("Entered healing node");
                // RunAway decision
                if (behavior.attacking) {
                    console.log("Decided RunAway from current target");
                    runAwayFromTarget(entity);
                } else if (behavior.inRange.length > 0) {
                    console.log("Decided RunAway from relative range enemies");
                    runAwayFromRange(entity);
                }
                behavior.healing = true;

            // Collision checking
            } else if (behavior.colliding.length > 0) {
                console.log("Entered collision node");
                // How many attacking
                if (behavior.colliding.length == 1) {
                    console.log("Decided hit current target");
                    hitTarget(entity);
                } else if (behavior.colliding.length > 1) {
                    console.log("Decided hit strongest player in hit area");
                    hitStrongest(entity);
                }

            // Inrange check
            } else if (behavior.inRange.length > 0) {
                if (behavior.staticColide) {
                    console.log("Entered Searching inRange node with A*");
                    seekNearestInRangeWithA(entity, grid);
                    behavior.staticColide = false;
                } else {
                    console.log("Entered Searching inRange node");
                    seekNearestInRange(entity);
                }
                
            // Out range check
            } else if (behavior.inRange.length == 0) {
                if (behavior.staticColide) {
                    console.log("Entered Searching outRange node with A*");
                    seekNearestWithA(entity, grid);
                    behavior.staticColide = false;
                } else {
                    console.log("Entered Searching outRange node");
                    seekNearest(entity);
                }
            }
        });
    });

};

export { sys_UpdateBehavior, sys_CheckInRange };

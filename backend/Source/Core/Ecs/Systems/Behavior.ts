import { Vec2 } from "../../../Utils/Math";
import { Entity } from "../Core/Ecs";
import { EcsData } from "../Interfaces";

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

const seekNearest = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    const target = behavior.nearest ?? null;

    if (!target)
        return;
    
    const enemy = target.getTransform();
    
    const seekDir = enemy.pos.sub(transform.pos).normalize();

    rigidbody.velocity = seekDir.muls(status.speed);

    behavior.attacking = false;
}

const seekNearestInRange = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const transform = entity.getTransform();
    const rigidbody = entity.getRigidbody();

    let nearest: Entity | null = null;
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
    
    const seekDir = enemy.pos.sub(transform.pos).normalize();
    
    rigidbody.velocity = seekDir.muls(status.speed);

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
            if (lifePercent >= 50) {
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
                console.log("Entered Searching inRange node");
                seekNearestInRange(entity);
                
            // Out range check
            } else if (behavior.inRange.length == 0) {
                console.log("Entered Searching outRange node");
                seekNearest(entity);
            }
        });
    });

};

export { sys_UpdateBehavior, sys_CheckInRange };

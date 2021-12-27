import { Grid } from "../Components/Grid";
import { Entity } from "../Core/Ecs";


const strategy_HitEnemy = (entity:Entity, grid:Grid, deltaTime: number):void => {
    const behavior = entity.getBehavior();
    if (behavior.colliding.length == 1) {
        // console.log("Decided hit current target");
        _hitTarget(entity);
    } else if (behavior.colliding.length > 1) {
        // console.log("Decided hit strongest player in hit area");
        _hitStrongest(entity);
    }
}

const _hitTarget = (entity: Entity) => {
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

const _hitStrongest = (entity: Entity) => {
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


export { strategy_HitEnemy }
import { EcsData } from "../Interfaces";
import { StatusResult } from "../Components/Status";

type OnDieFn = (status: StatusResult) => (void);

interface DeadPlayer {
    results: StatusResult;
    callback: OnDieFn;
}

let deads: DeadPlayer[] = [];

const sys_DipatchDeaths = (data: EcsData, deltaTime: number): void => {
    deads.forEach((dead) => {
        dead.callback(dead.results);
    });

    deads = [];
}

const sys_UpdateStatus = (data: EcsData, deltaTime: number): void => {
    // Iterates through all status in system
    data.status.map((stats) => {
        stats.survived += deltaTime;
        if (stats.health <= 0) {
            if (!stats.lastHit)
                return;
                
            const hunterStatus = stats.lastHit.getStatus();
            const hunterBehavior = stats.lastHit.getBehavior();

            hunterStatus.kills += 1;
            hunterBehavior.attacking = false;

            stats.health = 0.0;

            deads.push({
                results: {
                    attack: stats.attack,
                    health: stats.health,
                    defense: stats.defense,
                    cooldown: stats.cooldown,
                    survived: stats.survived,
                    kills: stats.kills
                },
                callback: stats.onDie
            });
        }
    });
};

export { sys_UpdateStatus, sys_DipatchDeaths };
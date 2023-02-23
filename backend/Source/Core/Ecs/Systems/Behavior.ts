import { EcsData } from "../Interfaces";
import { strategy_Explore } from "../Strategies/Explore";
import { strategy_Flee } from "../Strategies/Flee";
import { strategy_HitEnemy } from "../Strategies/HitEnemy";
import { strategy_Seek, strategy_SeekNearest } from "../Strategies/Seek";
import { strategy_Evade } from "../Strategies/Evade";
import { Behavior } from "../Components/Behavior";
import { finalPlayersAreStuck, strategy_MoveAroundSquare } from "../Strategies/MoveAroundSquare";
import { isPlayerStuck, strategy_Unstuck } from "../Strategies/Unstuck";
import { strategy_moveOnPath } from "../Strategies/MonveOnPath";


const ENTITY_RANGE = 0.1;
const ENTITY_TIER_RANGE = 0.5;

const regeneration:Record<string, number> = {
"sigma": 0.035,
"alpha": 0.03,
"beta": 0.03,
"delta": 0.045,
};

let entitiesAlive = 0;

const sys_UpdateBehavior = (data: EcsData, deltaTime: number): void => {
   
    data.grids.map((grid) => {     
        grid.dynamics.map((dynamic) => {
            const entity = dynamic.entity;
            // Get current player components
            const status = entity.getStatus();
            const behavior = entity.getBehavior();
            const strategy = entity.getStrategy();
            const rigibody = entity.getRigidbody();

            // reset state
            status.beingHit = false;
            behavior.attacking = false;

            const lifePercent = (status.health / status.maxHealth) * 100;

            // Healing checks
            if (lifePercent >= strategy.okHealth) {
                behavior.healing = false;
            }

            if (lifePercent < 100) {
                status.health += regeneration[status.tier];
            }

            // Update cooldown
            behavior.refresh += deltaTime; 
            // special behavior designed to fix last two players who might get stuck at the end of the game
            if (finalPlayersAreStuck(dynamic)) {
                behavior.changeBehavior(strategy_MoveAroundSquare);                
            // temporary fix to check if individual players are stuck in other parts of the map                
            } else if (isPlayerStuck(dynamic)) {
                behavior.changeBehavior(strategy_Unstuck);
            // } else if (strategy.pathData && strategy.pathData.path) {
            //     behavior.changeBehavior(strategy_moveOnPath);
            } else {
                //otherwise by default, all entities are set to EXPLORE 
                behavior.changeBehavior(strategy_Explore);
                
                if ((lifePercent < strategy.criticalHealth || behavior.healing) && entitiesAlive > 5 && !Behavior.berserker) {
                    // RunAway decision
                    if (status.tier == "delta") {
                        behavior.changeBehavior(strategy_Evade);
                    } else {
                        behavior.changeBehavior(strategy_Flee);        
                    }
                    behavior.healing = true;
                // Collision checking
                } else if (behavior.colliding.length > 0) {
                    behavior.changeBehavior(strategy_HitEnemy);
                // Inrange check
                } else if (behavior.inRange.length > 0) {
                    behavior.changeBehavior(strategy_Seek); 
                // Out range check
                } else if (behavior.inRange.length == 0) {
                    behavior.changeBehavior(strategy_SeekNearest); 
                }                
            }
            // execute behavior
            //behavior.changeBehavior(strategy_SeekNearest);
            behavior.current(entity, grid);
        });
    });
};


const sys_CheckForBerserker = (data: EcsData, deltaTime: number): void => {
    if ((Date.now() - Behavior.lastDeath) >= 5000) {
        Behavior.berserker = true;
    } else {
        Behavior.berserker = false;
    }
}

const sys_CheckInRange = (data: EcsData, deltaTime: number): void => {

    //reset battle state
    entitiesAlive = 0;

    data.grids.map((grid) => {
        // Clear last inRange check
        grid.dynamics.map((dynamic) => {
            const behavior = dynamic.entity.getBehavior();
            const status = dynamic.entity.getStatus();
            behavior.inRange = [];
            behavior.nearest = null;
            behavior.inRangeByTier = {};
            behavior.nearestByTier = {};
            if (status.health > 0) {
                entitiesAlive += 1;
            }
        });
        
        const shotestByTier:Record<string, number> = {};
        
        for (let i = 0; i < grid.dynamics.length; ++i) {
            // Get current entity
            const entity = grid.dynamics[i].entity;
            if (entity.destroyed || entity.getStatus().health <= 0) continue;

            // Get its components
            const behavior = entity.getBehavior();
            const transform = entity.getTransform();
            const status = entity.getStatus();
            
            // Init max int to sort distances
            let shortestDist = Number.MAX_SAFE_INTEGER;
            shotestByTier['delta'] = Number.MAX_SAFE_INTEGER;
            shotestByTier['beta'] = Number.MAX_SAFE_INTEGER;
            shotestByTier['alpha'] = Number.MAX_SAFE_INTEGER;
            shotestByTier['sigma'] = Number.MAX_SAFE_INTEGER;

            // For any other non checked entity
            for (let j = i + 1; j < grid.dynamics.length; ++j) {
                // Get other entity
                const other = grid.dynamics[j].entity;

                if (other.destroyed || other.getStatus().health <= 0) continue;
                
                // Get other entity tranform
                const otherBehavior = other.getBehavior();
                const otherTransform = other.getTransform();
                const otherTier = other.getStatus().tier;
                
                if (!otherBehavior || !otherTransform)
                    continue;

                // Calculates the dist to other entity
                const dist = transform.pos.sub(
                    otherTransform.pos
                ).length();
                
                // If other entity is in range add to array
                if (dist <= ENTITY_RANGE) {
                    behavior.inRange.push(other);
                    otherBehavior.inRange.push(entity);
                }

                if (!otherBehavior.inRangeByTier[status.tier]) otherBehavior.inRangeByTier[status.tier] = [];
                if (!behavior.inRangeByTier[otherTier]) behavior.inRangeByTier[otherTier] = [];

                if (dist <= ENTITY_TIER_RANGE) {
                    otherBehavior.inRangeByTier[status.tier].push(entity); 
                    behavior.inRangeByTier[otherTier].push(other); 
                }

                // If other entity is the nearest
                if (dist < shortestDist) {
                    behavior.nearest = other;
                    shortestDist = dist;
                }
                if (dist < shotestByTier[otherTier]) {
                    behavior.nearestByTier[otherTier] = other;
                    shotestByTier[otherTier] = dist;
                }

                if (!otherBehavior.nearest) {
                    otherBehavior.nearest = entity;
                }
                
                if (!otherBehavior.nearestByTier[status.tier]) {
                    otherBehavior.nearestByTier[status.tier] = entity;
                }

                // Checks if other entity nearest will change
                const otherShortestDist = otherTransform.pos.sub(
                    otherBehavior.nearest.getTransform().pos
                ).length();

                if (dist < otherShortestDist) {
                    otherBehavior.nearest = entity;
                    otherBehavior.nearestByTier[status.tier] = entity;
                }
            }
        }
    });    
}

export { entitiesAlive, sys_UpdateBehavior, sys_CheckInRange, sys_CheckForBerserker };

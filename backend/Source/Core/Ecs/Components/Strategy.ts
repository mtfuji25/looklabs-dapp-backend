import { PlayerLayer } from "../../../Layers/Lobby/Player";
import { Vec2 } from "../../../Utils/Math";
import { Entity } from "../Core/Ecs";
import { PathData } from "../Interfaces";
import { DangerZone } from "../Strategies/Unstuck";
import { entitiesAlive } from "../Systems/Behavior";

class Strategy {

    public criticalHealth:number = 35;
    public okHealth:number = 40;
    public pathData:PathData;
    public dangerZone:DangerZone | null;
    public stuckStartTime:number;
    private entity:Entity;
    private tierPriority:string[];

    constructor (entity:Entity) {
        this.entity = entity;

        const status = entity.getStatus();
        const r = Math.floor(Math.random() * 100);
        
        switch (status.tier) {

        case "sigma":
            this.criticalHealth = 20;
            this.okHealth = 25;
            if (r > 70) {
                this.tierPriority = ["sigma","beta","alpha",];
            } else if (r > 50) {
                this.tierPriority = ["beta","alpha","sigma"];
            } else {
                this.tierPriority = ["sigma", "alpha", "beta"];
            }

            break;
        case "alpha":        
            this.criticalHealth = 20;
            this.okHealth = 25;
            if (r > 70) {
                this.tierPriority = ["alpha","beta","sigma"];
            } else if (r > 50) {
                this.tierPriority = ["beta","alpha","sigma",];
            } else {
                this.tierPriority = ["sigma","beta","alpha"];
            }
           
            break;
        case "beta":
            if (r > 50) {
                this.tierPriority = ["beta","sigma","alpha"];
            } else {
                this.tierPriority = ["beta","alpha","sigma"];
            }
            break;
        default:
            this.criticalHealth = 45;
            this.okHealth = 50;
            this.tierPriority = ["beta","delta"];
            break;
        }

    }

    public getTierPriority ():string[] {

        const status = this.entity.getStatus();
        const lifePercent = (status.health / status.maxHealth) * 100;
        
        if (entitiesAlive < 5) return [];        

        switch (status.tier) {
            case "sigma":
            case "alpha":    
                return this.tierPriority;                
            case "beta":
                if (lifePercent > this.criticalHealth) {
                    if (status.attack > PlayerLayer.MAX_ATTACK * 0.65 ) {
                        return ["alpha", "sigma", "beta"];
                    }
                }
                return this.tierPriority;
                
            default:
                if (lifePercent > this.criticalHealth) {
                    if (status.attack > PlayerLayer.MAX_ATTACK * 0.4) {
                        return ["beta",  "delta", "alpha",  "sigma"];
                    }
                    
                } 
                return this.tierPriority;
        }
    }

    static pickTargetsInRange (entity:Entity,  priorityTier:string[]):Entity[] {
        const behavior = entity.getBehavior();
        let result:Entity[] = [];
        priorityTier.forEach ( tier => {
            if (behavior.inRangeByTier[tier] !== undefined) {
                result = [ ...result, ...behavior.inRangeByTier[tier]  ];
            }
        });
        return result;
    }

    static pickNearestTarget (entity:Entity,  priorityTier:string[]):Entity {
        const behavior = entity.getBehavior();
        priorityTier.forEach ( tier => {
            if (behavior.nearestByTier[tier] !== undefined) return behavior.nearestByTier[tier];
        });

        //if all else fails, return nearest
        if (behavior.nearest) return behavior.nearest;
        return null;
    }

    static pickTargetByPriority (entities:Entity[], priorityTier:string[]):Entity {

        priorityTier.forEach( (tier) => {
            const target = entities.find ( entity => entity.getStatus().tier == tier);
            if (target) return target;
        });
    
        // If all else fails, Sort based on attack
        entities.sort((a, b) => {
            const attackA = a.getStatus().attack;
            const attackB = b.getStatus().attack;
            if (attackA > attackB)
                return -1;
            if (attackA < attackB)
                return 1;
            return 0;
        });
    
        // Get strongest enemy
        return entities[0];
    }

}

export { Strategy }


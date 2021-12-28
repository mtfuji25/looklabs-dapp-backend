import { PlayerLayer } from "../../../Layers/Lobby/Player";
import { Entity } from "../Core/Ecs";
import { entitiesAlive } from "../Systems/Behavior";

class Strategy {

    public criticalHealth:number;
    public okHealth:number;
    private entity:Entity;
    private aggressive:boolean;

    constructor (entity:Entity) {
        this.entity = entity;

        const status = entity.getStatus();
        
        switch (status.tier) {

        case "sigma":
            this.criticalHealth = 20;
            this.okHealth = 30;
            break;
        case "alpha":        
            this.criticalHealth = 30;
            this.okHealth = 40;
            break;
        case "beta":
            this.criticalHealth = 35;            
            this.okHealth = 45;
            break;
        default:
            this.criticalHealth = 45;
            this.okHealth = 55;
            break;
        }

        this.aggressive = Math.random() > 0.5;
    }

    public getTierPriority ():string[] {

        const status = this.entity.getStatus();
        const lifePercent = (status.health / status.maxHealth) * 100;
        
        if (entitiesAlive < 5) return ["sigma","alpha","beta","delta"];        

        switch (status.tier) {
            case "sigma":
                if (this.aggressive) {
                    return ["sigma","alpha"];                
                }
                return ["alpha","sigma","beta"];                
            case "alpha":    
                if (this.aggressive) {
                    return ["sigma","alpha"];                
                } 
                return ["alpha","sigma","beta"];                
                    
            case "beta":
                if (lifePercent > this.criticalHealth) {
                    if (status.attack > PlayerLayer.MAX_ATTACK * 0.7) {
                        return ["alpha", "sigma", "beta"];
                    }
                    if (this.aggressive) 
                        return ["alpha", "beta", "delta", "sigma"];
                    return ["beta", "delta", "alpha", "sigma"];
                }
                return ["beta", "delta"];
                
            default:
                if (lifePercent > this.criticalHealth) {
                    if (status.attack > PlayerLayer.MAX_ATTACK * 0.4) {
                        if (this.aggressive) 
                            return ["alpha", "beta", "sigma", "delta" ];
                        return ["beta", "delta"];
                    }
                    return ["beta", "delta", "alpha", "sigma"];
                } 
                return ["delta"];
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

        if (behavior.nearest) return behavior.nearest;
        return null;
    }

    static pickTargetByPriority (entities:Entity[], priorityTier:string[]):Entity {

        priorityTier.forEach( (tier) => {
            const target = entities.find ( entity => entity.getStatus().tier == tier);
            if (target) return target;
        });
    
        // Sort based on attack
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


import { PlayerLayer } from "../../../Layers/Lobby/Player";
import { clamp } from "../../../Utils/Math";
import { Entity } from "../Core/Ecs";

interface StatusResult {
    attack: number;
    health: number;
    defense: number;
    cooldown: number;
    survived: number;
    kills: number;
}

type OnDieFn = (status: StatusResult) => (void);
type OnDamageFn = (damage: number) => (void);

class Status {

    // Current Entity Status
    public health: number;
    public readonly attack: number;
    public readonly speed: number;
    public readonly defense: number;
    public readonly cooldown: number;
    public readonly maxHealth: number;
    public readonly name: string;
    public readonly tier: string;
    
    public critical: boolean = false;

    // Current Entity Stats
    public survived: number = 0.0;
    public kills: number = 0.0;
    public beingHit: boolean = false;

    // Other enemy status
    public lastHit: Entity;

    public onDie: OnDieFn = () => {};
    public onDamage: OnDamageFn = () => {};

    constructor(
        attack: number,
        speed: number,
        health: number,
        defense: number,
        cooldown: number,
        name: string,
        tier: string        
    ) {
        this.attack = attack;
        this.health = health;
        this.speed = speed;
        this.defense = defense;
        this.maxHealth = health;
        this.cooldown = cooldown;
        this.name = name;
        this.tier = tier;
    }

    hit(enemy: Entity) {
        
        this.lastHit = enemy;
        this.beingHit = true;

        const status = enemy.getStatus();
        let damage = status.attack;
        

        if (status.health > 0.0) {

            if (this.tier == "delta" && (status.tier == "sigma" || status.tier == "alpha")) {
                if (Math.random() > 0.5) {
                    const healthMult = status.health / PlayerLayer.MAX_HEALTH;
                    damage *= clamp(healthMult, 0.7, 1.0);
                }
            }
            // 8% critical rate
            if (Math.random() < 0.08) {
                damage += Math.random() * (PlayerLayer.MAX_ATTACK * 2);
                this.lastHit.getStatus().critical = true;
            } else {
                // 15% miss rate
                if (Math.random() < 0.15) {
                    damage -= Math.random() * (PlayerLayer.MAX_ATTACK * 2);
                }
            }

            // Not allow negative damage
            if (damage < 1)
                damage = 1;

            if (damage <= this.defense) {
                this.health -= 1;
            } else {
                this.health -= damage -  this.defense;
            }
            
        }
    }

    setOnDie(fn: OnDieFn) {
        this.onDie = fn;
    }

    setOnDamage(fn: OnDamageFn) {
        this.onDamage = fn;
    }

    log() {
        console.log(`PLAYER TIER: ${this.tier} ATTACK: ${(100 * this.attack)/PlayerLayer.MAX_ATTACK}` );
    }
}

export { Status, StatusResult };

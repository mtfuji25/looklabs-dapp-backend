"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Status = void 0;
var Status = /** @class */ (function () {
    function Status(attack, speed, health, defense, cooldown, name) {
        // Current Entity Stats
        this.survived = 0.0;
        this.kills = 0.0;
        this.onDie = function () { };
        this.attack = attack;
        this.health = health;
        this.speed = speed;
        this.defense = defense;
        this.maxHealth = health;
        this.cooldown = cooldown;
        this.name = name;
    }
    Status.prototype.hit = function (enemy) {
        this.lastHit = enemy;
        var damage = enemy.getStatus().attack;
        // 8% critical rate
        if (Math.random() < 0.08) {
            damage += Math.random() * 30;
        }
        else {
            // 15% miss rate
            if (Math.random() < 0.15) {
                damage -= Math.random() * 30;
            }
        }
        // Not allow negative damage
        if (damage < 1)
            damage = 1;
        if (damage <= this.defense) {
            this.health -= 1;
        }
        else {
            this.health -= damage - this.defense;
        }
    };
    Status.prototype.setOnDie = function (fn) {
        this.onDie = fn;
    };
    return Status;
}());
exports.Status = Status;

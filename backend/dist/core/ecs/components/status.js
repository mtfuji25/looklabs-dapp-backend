"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.StatusComponent = void 0;
var StatusComponent = /** @class */ (function () {
    function StatusComponent(health, defense) {
        this.health = 0;
        this.defense = 0;
        this.onSelfDie = function () { };
        this.notifyHunter = function () { };
        this.health = health;
        this.defense = defense;
    }
    StatusComponent.prototype.hit = function (attack) {
        var damage = attack;
        // Checks for critical hit, 8% of chance
        if (Math.random() < 0.08) {
            damage += Math.random() * 30;
        }
        else {
            // Checks for miss hit, 15% of chance
            if (Math.random() < 0.1) {
                damage -= Math.random() * 30;
            }
        }
        // Not allow negative damage
        if (damage < 0)
            damage = 1;
        if (this.defense >= damage) {
            this.health -= 1;
        }
        else {
            this.health -= (damage - this.defense);
        }
    };
    StatusComponent.prototype.onDie = function () {
        this.onSelfDie();
        this.notifyHunter();
    };
    return StatusComponent;
}());
exports.StatusComponent = StatusComponent;

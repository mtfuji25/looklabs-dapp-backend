"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sys_DipatchDeaths = exports.sys_UpdateStatus = void 0;
var deads = [];
var sys_DipatchDeaths = function (data, deltaTime) {
    deads.forEach(function (dead) {
        dead.callback(dead.results);
    });
    deads = [];
};
exports.sys_DipatchDeaths = sys_DipatchDeaths;
var sys_UpdateStatus = function (data, deltaTime) {
    // Iterates through all status in system
    data.status.map(function (stats) {
        stats.survived += deltaTime;
        if (stats.health <= 0) {
            if (!stats.lastHit)
                return;
            var hunterStatus = stats.lastHit.getStatus();
            var hunterBehavior = stats.lastHit.getBehavior();
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
exports.sys_UpdateStatus = sys_UpdateStatus;

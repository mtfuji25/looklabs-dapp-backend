"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sysUpdateStatus = void 0;
var sysUpdateStatus = function (data, deltaTime) {
    // Iterates through all rigidbodys in system
    data.status.map(function (stats) {
        if (stats.health <= 0) {
            stats.onDie();
        }
    });
};
exports.sysUpdateStatus = sysUpdateStatus;

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sys_UpdatePos = void 0;
var sys_UpdatePos = function (data, deltaTime) {
    // Iterates through all rigidbodys in system
    data.rigidbodys.forEach(function (rigidbody) {
        var transform = rigidbody.rectangle.transform;
        transform.pos.x += rigidbody.velocity.x * deltaTime;
        transform.pos.y += rigidbody.velocity.y * deltaTime;
    });
};
exports.sys_UpdatePos = sys_UpdatePos;

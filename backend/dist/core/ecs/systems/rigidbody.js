"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sysUpdatePos = void 0;
var sysUpdatePos = function (data, deltaTime) {
    // Iterates through all rigidbodys in system
    data.rigidbodys.forEach(function (rigidbody) {
        var transform = rigidbody.rectangle.transform;
        transform.pos.x += rigidbody.velocity.x * deltaTime;
        transform.pos.y += rigidbody.velocity.y * deltaTime;
    });
};
exports.sysUpdatePos = sysUpdatePos;

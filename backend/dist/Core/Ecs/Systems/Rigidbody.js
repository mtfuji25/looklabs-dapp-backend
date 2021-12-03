"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sys_UpdatePos = void 0;
var console_1 = require("console");
var sys_UpdatePos = function (data, deltaTime) {
    // Iterates through all rigidbodys in system
    data.rigidbodys.forEach(function (rigidbody) {
        var transform = rigidbody.rectangle.transform;
        if (!transform)
            return;
        (0, console_1.assert)(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), "Rigidibody: ".concat(rigidbody, " Is NaN"));
        transform.pos.x += rigidbody.velocity.x * deltaTime;
        transform.pos.y += rigidbody.velocity.y * deltaTime;
    });
};
exports.sys_UpdatePos = sys_UpdatePos;

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sysDispatchCollisions = exports.sysGridCollision = void 0;
var ecs_1 = require("../core/ecs");
// For neighbor checks
var offsetX = [-1, 0, 1, 1, 1, 0, -1, -1];
var offsetY = [-1, -1, -1, 0, 1, 1, 1, 0];
var passResult = [];
var sysDispatchCollisions = function (data, deltaTime) {
    passResult.map(function (event) {
        event.caller.onCollision(event.other, event.result);
    });
};
exports.sysDispatchCollisions = sysDispatchCollisions;
var sysGridCollision = function (data, deltaTime) {
    data.grids.forEach(function (grid) {
        var _loop_1 = function (i) {
            var entity = grid.dynamics[i];
            // Get current dynamic entity rigidbody
            var rigidbody = entity.entity.getComponent[ecs_1.Rigidbody]();
            // If there is no rigidbody continue
            if (!rigidbody)
                return "continue";
            //
            //  First pass for dynamic entities
            //
            // Store entities ordered by contact time
            var sortedEntities = [];
            for (var j = i + 1; j < grid.dynamics.length; ++j) {
                // Get other dynamic entity rigidbody
                var otherRigidbody = grid.dynamics[j].entity.getComponent[ecs_1.Rigidbody]();
                // If other entity does not has rigidbody continue
                if (!otherRigidbody)
                    continue;
                // Test collision against other entity
                var result = rigidbody.colide(otherRigidbody, deltaTime);
                if (result.intersect) {
                    sortedEntities.push({
                        other: otherRigidbody,
                        result: result
                    });
                    passResult.push({
                        caller: rigidbody,
                        other: grid.dynamics[j].entity,
                        result: result
                    });
                    passResult.push({
                        caller: otherRigidbody,
                        other: entity.entity,
                        result: result
                    });
                }
            }
            // Sorts based on contact time
            sortedEntities.sort(function (a, b) {
                if (Math.abs(a.result.contactTime) < Math.abs(b.result.contactTime))
                    return -1;
                if (Math.abs(a.result.contactTime) > Math.abs(b.result.contactTime))
                    return 1;
                return 0;
            });
            // Solves the collison
            sortedEntities.forEach(function (_a) {
                var other = _a.other, result = _a.result;
                // Fix for current entity
                rigidbody.velocity.x += result.contactNormal.x * Math.abs(rigidbody.velocity.x) * (1.0 - result.contactTime);
                rigidbody.velocity.y += result.contactNormal.y * Math.abs(rigidbody.velocity.y) * (1.0 - result.contactTime);
                // Fix for other entity
                other.velocity.x += (result.contactNormal.x * -1.0) * Math.abs(other.velocity.x) * (1.0 - result.contactTime);
                other.velocity.y += (result.contactNormal.y * -1.0) * Math.abs(other.velocity.y) * (1.0 - result.contactTime);
            });
            //
            //  Second pass for static cells
            //
            var sortedStatics = [];
            // Check static neighbour
            for (var i_1 = 0; i_1 < 8; ++i_1) {
                var nx = entity.index.x + offsetX[i_1];
                var ny = entity.index.y + offsetY[i_1];
                if (nx < 0 || nx >= grid.width || ny < 0 || ny >= grid.height)
                    continue;
                var other = grid.statics[ny * grid.height + nx];
                if (!other)
                    continue;
                var result = rigidbody.colideStatic(other, deltaTime);
                if (result.intersect) {
                    sortedStatics.push(result);
                    passResult.push({
                        caller: rigidbody,
                        other: null,
                        result: result
                    });
                }
            }
            // Sorts based on contact time
            sortedStatics.sort(function (a, b) {
                if (Math.abs(a.contactTime) < Math.abs(b.contactTime))
                    return -1;
                if (Math.abs(a.contactTime) > Math.abs(b.contactTime))
                    return 1;
                return 0;
            });
            // Solves the collison
            sortedStatics.forEach(function (result) {
                // Fix for current entity
                rigidbody.velocity.x += result.contactNormal.x * Math.abs(rigidbody.velocity.x) * (1.0 - result.contactTime);
                rigidbody.velocity.y += result.contactNormal.y * Math.abs(rigidbody.velocity.y) * (1.0 - result.contactTime);
            });
        };
        for (var i = 0; i < grid.dynamics.length; ++i) {
            _loop_1(i);
        }
    });
};
exports.sysGridCollision = sysGridCollision;

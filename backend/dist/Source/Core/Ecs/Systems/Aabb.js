"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sys_CheckOverlap = void 0;
var aabbCheck = function (rec1, rec2) {
    var center1 = rec1.getCenter();
    var center2 = rec2.getCenter();
    if (center1.x < center2.x + rec2.width &&
        center1.x + rec1.width > center2.x &&
        center1.y < center2.y + rec2.height &&
        rec1.height + center1.y > center2.y) {
        return true;
    }
    return false;
};
var sys_CheckOverlap = function (data, deltaTime) {
    // Iterates through all grids in system
    data.grids.map(function (grid) {
        for (var i = 0; i < grid.dynamics.length; ++i) {
            var rec1 = grid.dynamics[i].entity.getRectangle();
            for (var j = i + 1; j < grid.dynamics.length; ++j) {
                var rec2 = grid.dynamics[j].entity.getRectangle();
                if (aabbCheck(rec1, rec2)) {
                    var rigidbody = grid.dynamics[i].entity.getRigidbody();
                    var otherRigidbody = grid.dynamics[j].entity.getRigidbody();
                    var transform = grid.dynamics[i].entity.getTransform();
                    var otherTransform = grid.dynamics[j].entity.getTransform();
                    if ((!transform) || (!otherTransform))
                        continue;
                    rigidbody.rectangle.transform.pos.x -= rigidbody.velocity.x * deltaTime;
                    rigidbody.rectangle.transform.pos.y -= rigidbody.velocity.y * deltaTime;
                    otherRigidbody.rectangle.transform.pos.x -= otherRigidbody.velocity.x * deltaTime;
                    otherRigidbody.rectangle.transform.pos.y -= otherRigidbody.velocity.y * deltaTime;
                }
            }
        }
    });
};
exports.sys_CheckOverlap = sys_CheckOverlap;

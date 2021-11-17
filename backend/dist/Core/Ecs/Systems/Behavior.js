"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sys_CheckInRange = exports.sys_UpdateBehavior = void 0;
var Math_1 = require("../../../Utils/Math");
var ENTITY_RANGE = 0.1;
var runAwayFromTarget = function (entity) {
    var _a;
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var tranform = entity.getTransform();
    var rigidbody = entity.getRigidbody();
    var target = (_a = behavior.target) !== null && _a !== void 0 ? _a : null;
    if (!target)
        return;
    var enemy = target.getTransform();
    var runAwayDir = tranform.pos.sub(enemy.pos).normalize();
    rigidbody.velocity = runAwayDir.muls(status.speed);
    behavior.attacking = false;
};
var runAwayFromRange = function (entity) {
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var tranform = entity.getTransform();
    var rigidbody = entity.getRigidbody();
    var range = behavior.inRange;
    var relativeEnemy = new Math_1.Vec2();
    range.map(function (enemy) {
        var pos = enemy.getTransform().pos;
        relativeEnemy = relativeEnemy.add(pos);
    });
    var runAwayDir = tranform.pos.sub(relativeEnemy).normalize();
    rigidbody.velocity = runAwayDir.muls(status.speed);
    behavior.attacking = false;
};
var hitTarget = function (entity) {
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var enemy = behavior.colliding[0];
    if (!enemy)
        return;
    // Checks if is able to hit other enemy
    if (behavior.refresh >= status.cooldown) {
        var enemyStatus = enemy.getStatus();
        enemyStatus.hit(entity);
        behavior.target = enemy;
        behavior.attacking = true;
        behavior.refresh = 0.0;
    }
    else {
        behavior.attacking = false;
    }
};
var hitStrongest = function (entity) {
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    // Sort based on attack
    behavior.colliding.sort(function (a, b) {
        var attackA = a.getStatus().attack;
        var attackB = b.getStatus().attack;
        if (attackA > attackB)
            return -1;
        if (attackA < attackB)
            return 1;
        return 0;
    });
    // Get strongest enemy
    var enemy = behavior.colliding[0];
    // Checks if is able to hit other enemy
    if (behavior.refresh >= status.cooldown) {
        var enemyStatus = enemy.getStatus();
        enemyStatus.hit(entity);
        behavior.target = enemy;
        behavior.attacking = true;
        behavior.refresh = 0.0;
    }
    else {
        behavior.attacking = false;
    }
};
var seekNearest = function (entity) {
    var _a;
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var transform = entity.getTransform();
    var rigidbody = entity.getRigidbody();
    var target = (_a = behavior.nearest) !== null && _a !== void 0 ? _a : null;
    if (!target)
        return;
    var enemy = target.getTransform();
    var seekDir = enemy.pos.sub(transform.pos).normalize();
    rigidbody.velocity = seekDir.muls(status.speed);
    behavior.attacking = false;
};
var seekNearestInRange = function (entity) {
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var transform = entity.getTransform();
    var rigidbody = entity.getRigidbody();
    var nearest = null;
    var shortestDist = Number.MAX_SAFE_INTEGER;
    behavior.inRange.map(function (other) {
        var dist = transform.pos.sub(other.getTransform().pos).length();
        if (dist < shortestDist) {
            nearest = other;
            shortestDist = dist;
        }
    });
    if (!nearest)
        return;
    var enemy = nearest.getTransform();
    var seekDir = enemy.pos.sub(transform.pos).normalize();
    rigidbody.velocity = seekDir.muls(status.speed);
    behavior.attacking = false;
};
var sys_CheckInRange = function (data, deltaTime) {
    data.grids.map(function (grid) {
        // Clear last inRange check
        grid.dynamics.map(function (dynamic) {
            var behavior = dynamic.entity.getBehavior();
            behavior.inRange = [];
            behavior.nearest = null;
        });
        for (var i = 0; i < grid.dynamics.length; ++i) {
            // Get current entity
            var entity = grid.dynamics[i].entity;
            // Get its components
            var behavior = entity.getBehavior();
            var transform = entity.getTransform();
            // Init max int to sort distances
            var shortestDist = Number.MAX_SAFE_INTEGER;
            // For any other non checked entity
            for (var j = i + 1; j < grid.dynamics.length; ++j) {
                // Get other entity
                var other = grid.dynamics[j].entity;
                // Get other entity tranform
                var otherBehavior = other.getBehavior();
                var otherTransform = other.getTransform();
                if (!otherBehavior)
                    return;
                if (!otherTransform)
                    return;
                // Calculates the dist to other entity
                var dist = transform.pos.sub(otherTransform.pos).length();
                // If other entity is in range add to array
                if (dist <= ENTITY_RANGE) {
                    behavior.inRange.push(other);
                    otherBehavior.inRange.push(entity);
                }
                // If other entity is the nearest
                if (dist < shortestDist) {
                    behavior.nearest = other;
                    shortestDist = dist;
                }
                if (!otherBehavior.nearest)
                    otherBehavior.nearest = entity;
                // Checks if other entity nearest will change
                var otherShortestDist = otherTransform.pos.sub(otherBehavior.nearest.getTransform().pos).length();
                if (dist < otherShortestDist) {
                    otherBehavior.nearest = entity;
                }
            }
        }
    });
};
exports.sys_CheckInRange = sys_CheckInRange;
var sys_UpdateBehavior = function (data, deltaTime) {
    data.grids.map(function (grid) {
        grid.dynamics.map(function (dynamic) {
            var entity = dynamic.entity;
            // Get current player components
            var status = entity.getStatus();
            var behavior = entity.getBehavior();
            // Get current life percent of player
            var lifePercent = (status.health / status.maxHealth) * 100;
            // Update cooldown
            behavior.refresh += deltaTime;
            // Healing checks
            if (lifePercent >= 50) {
                behavior.healing = false;
            }
            if (lifePercent < 100) {
                status.health += 0.001;
            }
            // Life check
            if (lifePercent < 25 || behavior.healing) {
                console.log("Entered healing node");
                // RunAway decision
                if (behavior.attacking) {
                    console.log("Decided RunAway from current target");
                    runAwayFromTarget(entity);
                }
                else if (behavior.inRange.length > 0) {
                    console.log("Decided RunAway from relative range enemies");
                    runAwayFromRange(entity);
                }
                behavior.healing = true;
                // Collision checking
            }
            else if (behavior.colliding.length > 0) {
                console.log("Entered collision node");
                // How many attacking
                if (behavior.colliding.length == 1) {
                    console.log("Decided hit current target");
                    hitTarget(entity);
                }
                else if (behavior.colliding.length > 1) {
                    console.log("Decided hit strongest player in hit area");
                    hitStrongest(entity);
                }
                // Inrange check
            }
            else if (behavior.inRange.length > 0) {
                console.log("Entered Searching inRange node");
                seekNearestInRange(entity);
                // Out range check
            }
            else if (behavior.inRange.length == 0) {
                console.log("Entered Searching outRange node");
                seekNearest(entity);
            }
        });
    });
};
exports.sys_UpdateBehavior = sys_UpdateBehavior;

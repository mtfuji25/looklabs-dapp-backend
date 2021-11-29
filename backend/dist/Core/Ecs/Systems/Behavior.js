"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.sys_CheckInRange = exports.sys_UpdateBehavior = void 0;
var Math_1 = require("../../../Utils/Math");
// AStar import
var astar_typescript_1 = require("astar-typescript");
// Map importing
var LevelCollider_json_1 = __importDefault(require("../../../Assets/LevelCollider.json"));
var finder = new astar_typescript_1.AStarFinder({
    grid: {
        matrix: LevelCollider_json_1.default["data"]
    },
    diagonalAllowed: false,
    includeStartNode: true,
    includeEndNode: true
});
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
    // Começo do solver
    var runAwayDir = new Math_1.Vec2();
    if (behavior.staticColide) {
        var resNormal_1 = new Math_1.Vec2();
        behavior.staticNormal.map(function (normal) {
            resNormal_1 = resNormal_1.add(normal);
        });
        // Performs suffle operation
        var tempX = resNormal_1.x;
        resNormal_1.x = resNormal_1.y;
        resNormal_1.y = tempX;
        console.log(resNormal_1);
        if (Math.abs(resNormal_1.x) === Math.abs(resNormal_1.y)) {
            runAwayDir = resNormal_1.muls(-1.0);
            var relativeEnemyPos = enemy.pos.sub(tranform.pos);
            if (Math.abs(relativeEnemyPos.x) === Math.abs(relativeEnemyPos.y)) {
                if (Math.random() < 0.5) {
                    runAwayDir.x = 0.0;
                }
                else {
                    runAwayDir.y = 0.0;
                }
            }
            else if (Math.abs(relativeEnemyPos.x) < Math.abs(relativeEnemyPos.y)) {
                runAwayDir.y = 0.0;
            }
            else {
                runAwayDir.x = 0.0;
            }
        }
        else if (Math.abs(resNormal_1.x) < Math.abs(resNormal_1.y)) {
            var relativeEnemyPos = enemy.pos.sub(tranform.pos);
            if (relativeEnemyPos.y < 0) {
                runAwayDir.x = 0.0;
                runAwayDir.y = 1.0;
            }
            else {
                runAwayDir.x = 0.0;
                runAwayDir.y = -1.0;
            }
        }
        else {
            var relativeEnemyPos = enemy.pos.sub(tranform.pos);
            if (relativeEnemyPos.x < 0) {
                runAwayDir.x = 1.0;
                runAwayDir.y = 0.0;
            }
            else {
                runAwayDir.x = -1.0;
                runAwayDir.y = 0.0;
            }
        }
        console.log("Get runaway dir");
    }
    else {
        runAwayDir = tranform.pos.sub(enemy.pos).normalize();
    }
    rigidbody.velocity = runAwayDir.normalize().muls(status.speed);
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
    var runAwayDir = new Math_1.Vec2();
    if (behavior.staticColide) {
        var resNormal_2 = new Math_1.Vec2();
        behavior.staticNormal.map(function (normal) {
            resNormal_2 = resNormal_2.add(normal);
        });
        // Performs suffle operation
        var tempX = resNormal_2.x;
        resNormal_2.x = resNormal_2.y;
        resNormal_2.y = tempX;
        console.log(resNormal_2);
        if (Math.abs(resNormal_2.x) === Math.abs(resNormal_2.y)) {
            runAwayDir = resNormal_2.muls(-1.0);
            var relativeEnemyPos = relativeEnemy.sub(tranform.pos);
            if (Math.abs(relativeEnemyPos.x) === Math.abs(relativeEnemyPos.y)) {
                if (Math.random() < 0.5) {
                    runAwayDir.x = 0.0;
                }
                else {
                    runAwayDir.y = 0.0;
                }
            }
            else if (Math.abs(relativeEnemyPos.x) < Math.abs(relativeEnemyPos.y)) {
                runAwayDir.y = 0.0;
            }
            else {
                runAwayDir.x = 0.0;
            }
        }
        else if (Math.abs(resNormal_2.x) < Math.abs(resNormal_2.y)) {
            var relativeEnemyPos = relativeEnemy.sub(tranform.pos);
            if (relativeEnemyPos.y < 0) {
                runAwayDir.x = 0.0;
                runAwayDir.y = 1.0;
            }
            else {
                runAwayDir.x = 0.0;
                runAwayDir.y = -1.0;
            }
        }
        else {
            var relativeEnemyPos = relativeEnemy.sub(tranform.pos);
            if (relativeEnemyPos.x < 0) {
                runAwayDir.x = 1.0;
                runAwayDir.y = 0.0;
            }
            else {
                runAwayDir.x = -1.0;
                runAwayDir.y = 0.0;
            }
        }
        console.log("Get runaway dir");
    }
    else {
        runAwayDir = tranform.pos.sub(relativeEnemy).normalize();
    }
    rigidbody.velocity = runAwayDir.normalize().muls(status.speed);
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
var seekNearestWithA = function (entity, grid) {
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var transform = entity.getTransform();
    var rigidbody = entity.getRigidbody();
    var nearest = behavior.nearest;
    if (!nearest)
        return;
    var other = grid.getDynamic(nearest);
    var dynamic = grid.getDynamic(entity);
    // Começo do solver
    var convertFromNDC = function (pos) {
        var position = pos.adds(1.0).divs(2.0);
        position.y = 1 - position.y;
        return position;
    };
    var convertToNDC = function (pos) {
        var position = new Math_1.Vec2(pos.x, 0 - pos.y);
        return position;
    };
    var convertCellToPos = function (cell) {
        var position = new Math_1.Vec2((cell.x * grid.intervalX / 2.0) - (grid.intervalX / 4.0), (cell.y * grid.intervalY / 2.0) - (grid.intervalY / 4.0));
        return position;
    };
    var convertPosToCell = function (pos) {
        var index = new Math_1.Vec2(Math.floor(pos.x / (grid.intervalX / 2.0)), Math.floor(pos.y / (grid.intervalY / 2.0)));
        return index;
    };
    // Sources and direction vectors
    var sources = [];
    var dir = null;
    behavior.staticCenter.map(function (center) {
        var convertedCenter = convertPosToCell(convertFromNDC(center));
        dynamic.ocupations.map(function (ocupation) {
            var diff = convertedCenter.abs(ocupation);
            // Checks if is axis aligned neighbor
            if ((diff.x == 0 && diff.y == 1) || (diff.x == 1 && diff.y == 0)) {
                sources.push(ocupation);
            }
        });
    });
    sources.map(function (source, index) {
        if (!dir)
            dir = new Math_1.Vec2();
        var path = finder.findPath(source, other.index);
        if (path.length < 2)
            return;
        var dest = convertCellToPos(new Math_1.Vec2(path[1][0], path[1][1]));
        var origin = convertCellToPos(new Math_1.Vec2(path[0][0], path[0][1]));
        if (!dest.equal(origin)) {
            dir = dir.add(dest.sub(origin));
        }
    });
    if (dir) {
        dir = convertToNDC(dir).normalize().muls(status.speed);
    }
    else {
        var enemyPos = nearest.getTransform().pos;
        if (!enemyPos.equal(transform.pos)) {
            dir = enemyPos.sub(transform.pos).normalize().muls(status.speed);
        }
    }
    rigidbody.velocity = dir;
    behavior.attacking = false;
};
var seekNearestInRangeWithA = function (entity, grid) {
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var transform = entity.getTransform();
    var rigidbody = entity.getRigidbody();
    var nearest;
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
    var other = grid.getDynamic(nearest);
    var dynamic = grid.getDynamic(entity);
    // Começo do solver
    var convertFromNDC = function (pos) {
        var position = pos.adds(1.0).divs(2.0);
        position.y = 1 - position.y;
        return position;
    };
    var convertToNDC = function (pos) {
        var position = new Math_1.Vec2(pos.x, 0 - pos.y);
        return position;
    };
    var convertCellToPos = function (cell) {
        var position = new Math_1.Vec2((cell.x * grid.intervalX / 2.0) - (grid.intervalX / 4.0), (cell.y * grid.intervalY / 2.0) - (grid.intervalY / 4.0));
        return position;
    };
    var convertPosToCell = function (pos) {
        var index = new Math_1.Vec2(Math.floor(pos.x / (grid.intervalX / 2.0)), Math.floor(pos.y / (grid.intervalY / 2.0)));
        return index;
    };
    // Sources and direction vectors
    var sources = [];
    var dir = null;
    behavior.staticCenter.map(function (center) {
        var convertedCenter = convertPosToCell(convertFromNDC(center));
        dynamic.ocupations.map(function (ocupation) {
            var diff = convertedCenter.abs(ocupation);
            // Checks if is axis aligned neighbor
            if ((diff.x == 0 && diff.y == 1) || (diff.x == 1 && diff.y == 0)) {
                sources.push(ocupation);
            }
        });
    });
    sources.map(function (source, index) {
        if (!dir)
            dir = new Math_1.Vec2();
        var path = finder.findPath(source, other.index);
        if (path.length < 2)
            return;
        var dest = convertCellToPos(new Math_1.Vec2(path[1][0], path[1][1]));
        var origin = convertCellToPos(new Math_1.Vec2(path[0][0], path[0][1]));
        if (!dest.equal(origin)) {
            dir = dir.add(dest.sub(origin));
        }
    });
    if (dir) {
        dir = convertToNDC(dir).normalize().muls(status.speed);
    }
    else {
        var enemyPos = nearest.getTransform().pos;
        if (!enemyPos.equal(transform.pos)) {
            dir = enemyPos.sub(transform.pos).normalize().muls(status.speed);
        }
    }
    rigidbody.velocity = dir;
    behavior.attacking = false;
};
var seekNearest = function (entity) {
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var transform = entity.getTransform();
    var rigidbody = entity.getRigidbody();
    var target = behavior.nearest;
    if (!target)
        return;
    var enemy = target.getTransform();
    if (!enemy.pos.equal(transform.pos)) {
        rigidbody.velocity = enemy.pos.sub(transform.pos).normalize().muls(status.speed);
    }
    behavior.attacking = false;
};
var seekNearestInRange = function (entity) {
    var status = entity.getStatus();
    var behavior = entity.getBehavior();
    var transform = entity.getTransform();
    var rigidbody = entity.getRigidbody();
    var nearest;
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
    if (!enemy.pos.equal(transform.pos)) {
        rigidbody.velocity = enemy.pos.sub(transform.pos).normalize().muls(status.speed);
    }
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
                if (entity.destroyed || other.destroyed)
                    return;
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
            if (lifePercent >= 40) {
                behavior.healing = false;
            }
            if (lifePercent < 100) {
                status.health += 0.01;
            }
            // Life check
            if (lifePercent < 25 || behavior.healing) {
                // console.log("Entered healing node");
                // RunAway decision
                if (behavior.attacking) {
                    // console.log("Decided RunAway from current target");
                    runAwayFromTarget(entity);
                }
                else if (behavior.inRange.length > 0) {
                    // console.log("Decided RunAway from relative range enemies");
                    runAwayFromRange(entity);
                }
                behavior.healing = true;
                // Collision checking
            }
            else if (behavior.colliding.length > 0) {
                // console.log("Entered collision node");
                // How many attacking
                if (behavior.colliding.length == 1) {
                    // console.log("Decided hit current target");
                    hitTarget(entity);
                }
                else if (behavior.colliding.length > 1) {
                    // console.log("Decided hit strongest player in hit area");
                    hitStrongest(entity);
                }
                // Inrange check
            }
            else if (behavior.inRange.length > 0) {
                if (behavior.staticColide) {
                    // console.log("Entered Searching inRange node with A*");
                    seekNearestInRangeWithA(entity, grid);
                    behavior.staticColide = false;
                }
                else {
                    // console.log("Entered Searching inRange node");
                    seekNearestInRange(entity);
                }
                // Out range check
            }
            else if (behavior.inRange.length == 0) {
                if (behavior.staticColide) {
                    // console.log("Entered Searching outRange node with A*");
                    seekNearestWithA(entity, grid);
                    behavior.staticColide = false;
                }
                else {
                    // console.log("Entered Searching outRange node");
                    seekNearest(entity);
                }
            }
        });
    });
};
exports.sys_UpdateBehavior = sys_UpdateBehavior;

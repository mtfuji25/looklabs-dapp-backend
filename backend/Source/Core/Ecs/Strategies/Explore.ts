import assert from "assert";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { Strategy } from "../Components/Strategy";
import { Entity } from "../Core/Ecs";
import { entitiesAlive } from "../Systems/Behavior";
import { strategy_SeekNearest } from "./Seek";

const strategy_Explore = (entity:Entity, grid:Grid, target?:Entity):void => {
  
  const status = entity.getStatus();
  const strategy = entity.getStrategy();
  const behavior = entity.getBehavior();  
  if (entitiesAlive > 80 || entitiesAlive == 1) {
    _wander(entity);
  } else {
    // if (behavior.staticCollide == false ) {
      if ( ((entitiesAlive > 60 || entitiesAlive < 15) &&  (status.tier == "sigma" || status.tier == "alpha" || status.tier == "beta")) ) {
        const targets = Strategy.pickTargetsInRange(entity, strategy.getTierPriority());
        if (targets && targets.length > 0) {
          strategy_SeekNearest(entity, grid, targets[0]);
          return;
        }
      }
    // } 
    _wander(entity);
  }
  
  
}

const NEW_DIRECTION_RANGE = Math.PI / 8;

const _wander = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const rigidbody = entity.getRigidbody();

    if (rigidbody.velocity.x === 0 && rigidbody.velocity.y === 0) return;

    if (behavior.wanderTime-- <= 0) {
        const angle = rigidbody.velocity.angle() + Math.random() *  NEW_DIRECTION_RANGE * behavior.wanderSteer;
        behavior.wanderVelocity = Vec2.fromAngle(angle, status.speed);
        behavior.wanderTime = Math.round(
          Math.random() * behavior.wanderTimeMax + behavior.wanderTimeMin
        );
      }
    

      if (behavior.wanderSteerChangeTime-- <= 0) {
        behavior.wanderSteer = Math.floor(Math.random() * 2) === 0 ? 1 : -1;
        behavior.wanderSteerChangeTime = Math.round(
          Math.random() * behavior.wanderTimeMax  * 5 + behavior.wanderTimeMin * 2
        );
      }
  
    rigidbody.velocity = behavior.wanderVelocity;
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Wander: ${rigidbody} Is NaN`);
    
}

export { strategy_Explore }
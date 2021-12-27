import assert from "assert";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { Entity } from "../Core/Ecs";

const strategy_Explore = (entity:Entity, grid:Grid, deltaTime: number):void => {
    _wander(entity);
}

const _wander = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const rigidbody = entity.getRigidbody();


    if (behavior.wanderTime-- <= 0) {
        const angle =
        rigidbody.velocity.angle() + Math.random() * Math.PI * behavior.wanderSteer;
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
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Behavior 6: ${rigidbody} Is NaN`);
    
}
export { strategy_Explore }
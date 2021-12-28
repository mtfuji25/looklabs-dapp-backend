import assert from "assert";
import { PlayerLayer } from "../../../Layers/Lobby/Player";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { Strategy } from "../Components/Strategy";
import { Entity } from "../Core/Ecs";
import { strategy_SeekNearest } from "./Seek";

const strategy_Explore = (entity:Entity, grid:Grid, target?:Entity):void => {

  const status = entity.getStatus();
  const strategy = entity.getStrategy();

  if (status.tier == "sigma" || status.tier == "alpha" || (status.tier == "beta" && status.attack >= PlayerLayer.MAX_ATTACK * 0.7)) {
    const targets = Strategy.pickTargetsInRange(entity, strategy.getTierPriority());
    if (targets && targets.length > 0) {
      strategy_SeekNearest(entity, grid, targets[0]);
      return;
    }
  }  
  _wander(entity);
  // _wander2(entity);

}

const _wander = (entity: Entity) => {
    const status = entity.getStatus();
    const behavior = entity.getBehavior();
    const rigidbody = entity.getRigidbody();

    if (rigidbody.velocity.x === 0 && rigidbody.velocity.y === 0) return;

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
    assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Wander: ${rigidbody} Is NaN`);
    
}

const _wander2  = (entity: Entity) => {
  const status = entity.getStatus();
  const transform = entity.getTransform();
  const behavior = entity.getBehavior();
  const rigidbody = entity.getRigidbody();

  if (rigidbody.velocity.x === 0 && rigidbody.velocity.y === 0) return;
  
  
  let wanderPoint = rigidbody.velocity.normalize().muls(100).add(transform.pos);
  let wanderRadius = 50;
  let theta = behavior.wanderTheta + rigidbody.velocity.angle();

  let x = wanderRadius * Math.cos(theta);
  let y = wanderRadius * Math.sin(theta);
  wanderPoint = wanderPoint.add(new Vec2(x, y));

  let f = wanderPoint.sub(transform.pos).normalize().muls(status.speed);
  
  rigidbody.velocity = f;
  assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Wander2: ${rigidbody} Is NaN`);

  let displaceRange = 0.3;
  behavior.wanderTheta += (Math.random() * displaceRange) - (Math.random() * displaceRange);

}
export { strategy_Explore }
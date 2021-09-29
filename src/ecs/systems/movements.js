import { ECS_CORE } from "../core/ecs";

const sysUpdateVel = (data, deltaTime) => {
    data[ECS_CORE.RIGIDBODY].forEach((body) => {
        body.velocity.x += body.acceleration.x * deltaTime;
        body.velocity.y += body.acceleration.y * deltaTime;
    });
}

const sysUpdatePos = (data, deltaTime) => {
    data[ECS_CORE.RIGIDBODY].forEach((body) => {
        body.transform.pos.x += body.velocity.x;
        body.transform.pos.y += body.velocity.y;
    });
}


export { sysUpdateVel, sysUpdatePos };
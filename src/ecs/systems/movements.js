import { ECS, ECS_CORE } from "../core/ecs";

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
    sysUpdateFloor(data, deltaTime);
}

const sysUpdateFloor = (data, deltaTime) => {
    data[ECS_CORE.RIGIDBODY].forEach((body) => {
        const FLOOR = ECS_CORE.getGlobal("app-height") - 200;
        if (body.transform.pos.y > FLOOR) {
            ECS.setGlobal("jumping", false);
            body.transform.pos.y = FLOOR;
            body.velocity.y = 0;
            if (body.velocity.x < 0.0) {
                body.velocity.x += 0.5;
            }
            if (body.velocity.x > 0.0) {
                body.velocity.x -= 0.5;
            }
        }
    });
}

export { sysUpdateVel, sysUpdatePos };
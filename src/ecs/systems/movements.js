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
    sysUpdateFloor(data, deltaTime);
}

const sysUpdateFloor = (data, deltaTime) => {
    data[ECS_CORE.RIGIDBODY].forEach((body) => {
        const FLOOR = ECS_CORE.getGlobal("app-height");
        console.log(FLOOR);
        if (body.transform.pos.y > FLOOR) {
            body.transform.pos.y = FLOOR;
            body.velocity.y = 0;
        }
    });
}

export { sysUpdateVel, sysUpdatePos };
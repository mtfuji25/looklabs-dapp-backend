import { ECS_CORE } from "../core/ecs";

const readjustCollision = (rec, other) => {
    
};

const sysCheckCollisions = (data, deltaTime) => {
    data[ECS_CORE.RECTANGLE].forEach((rec, i) => {
        if (rec.needCheck) {
            data[ECS_CORE.RECTANGLE].forEach((other, j) => {
                if (i != j) {
                    console.log(rec.checkCollision(other));
                }
            });
        }
    });
};

export { sysCheckCollisions };
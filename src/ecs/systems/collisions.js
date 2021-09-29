import { ECS_CORE } from "../core/ecs";

const sysCheckCollisions = (data, deltaTime) => {
    data[ECS_CORE.RECTANGLE].forEach((rec, i) => {
        if (rec.needCheck) {
            data[ECS_CORE.RECTANGLE].forEach((other, j) => {
                if (i != j) {
                    if (!(other.invisible)) {
                        while (rec.checkCollision(other)) {
                            rec.transform.pos.y -= 2;
                        }
                    }
                }
            });
        }
    });
};

export { sysCheckCollisions };
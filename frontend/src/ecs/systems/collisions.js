import { ECS_CORE } from "../core/ecs";



const sysCheckCollisions = (data, deltaTime) => {
    data[ECS_CORE.RECTANGLE].forEach((rec, i) => {
        if (rec.needCheck) {
            data[ECS_CORE.RECTANGLE].forEach((other, j) => {
                if (i != j) {
                    if (rec.checkCollision(other)) {
                        //rec.transform.pos.y = other.transform.pos.y - other.width / 2.0;
                    }
                }
            });
        }
    });
};

export { sysCheckCollisions };
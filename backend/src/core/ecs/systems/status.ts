import { EcsData } from "../../interfaces";

const sysUpdateStatus = (data: EcsData, deltaTime: number): void => {
    // Iterates through all rigidbodys in system
    data.status.map((stats) => {
        if (stats.health <= 0) {
            stats.onDie();
        }
    });
};

export { sysUpdateStatus };
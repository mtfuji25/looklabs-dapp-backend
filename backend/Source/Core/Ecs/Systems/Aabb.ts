import { Rectangle } from "../Components/Rectangle";
import { EcsData } from "../Interfaces";
import { collisionsResults } from "./Grid";

const aabbCheck = (rec1: Rectangle, rec2: Rectangle): boolean => {

    const center1 = rec1.getCenter();
    const center2 = rec2.getCenter();

    if (
        center1.x < center2.x + rec2.width &&
        center1.x + rec1.width > center2.x &&
        center1.y < center2.y + rec2.height &&
        rec1.height + center1.y > center2.y
    ){
        return true;
    }

    return false;
};

const sys_CheckOverlap = (data: EcsData, deltaTime: number): void => {
    // Iterates through all grids in system
    data.grids.map((grid) => {
        for (let i = 0; i < grid.dynamics.length; ++i) {
            const rec1 = grid.dynamics[i].entity.getRectangle();

            for (let j = i + 1; j < grid.dynamics.length; ++j) {
                const rec2 = grid.dynamics[j].entity.getRectangle();

                if (aabbCheck(rec1, rec2)) {

                    collisionsResults.push({
                        entity: grid.dynamics[i].entity,
                        other: grid.dynamics[j].entity
                    });

                    const rigidbody = grid.dynamics[i].entity.getRigidbody();
                    const otherRigidbody = grid.dynamics[j].entity.getRigidbody();

                    const transform = grid.dynamics[i].entity.getTransform()
                    const otherTransform = grid.dynamics[j].entity.getTransform()

                    if ((!transform) || (!otherTransform))
                        continue;

                    rigidbody.rectangle.transform.pos.x -= rigidbody.velocity.x * deltaTime;
                    rigidbody.rectangle.transform.pos.y -= rigidbody.velocity.y * deltaTime;

                    otherRigidbody.rectangle.transform.pos.x -= otherRigidbody.velocity.x * deltaTime;
                    otherRigidbody.rectangle.transform.pos.y -= otherRigidbody.velocity.y * deltaTime;
                }
            }
        }
    });
};

export { sys_CheckOverlap };
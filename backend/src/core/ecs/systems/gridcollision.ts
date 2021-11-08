import { EcsData } from "../../interfaces";
import { CollisionResult } from "../../../utils/collision";
import { Entity, Rigidbody } from "../core/ecs";
import { RigidbodyComponent } from "../components/rigidbody";

// For neighbor checks
const offsetX = [ -1,  0,  1,  1,  1,  0, -1, -1]
const offsetY = [ -1, -1, -1,  0,  1,  1,  1,  0]

interface SortedCollision {
    other: RigidbodyComponent;
    result: CollisionResult;
}

interface CollisionEvent {
    caller: RigidbodyComponent;
    other: Entity | null;
    result: CollisionResult;
}

const passResult: CollisionEvent[] = [];

const sysDispatchCollisions = (data: EcsData, deltaTime: number): void => {
    passResult.map((event) => {
        event.caller.onCollision(event.other, event.result);
    });
}

const sysGridCollision = (data: EcsData, deltaTime: number): void => {
    data.grids.forEach((grid) => {

        for (let i = 0; i < grid.dynamics.length; ++i) {

            const entity = grid.dynamics[i];

            // Get current dynamic entity rigidbody
            const rigidbody = entity.entity.getComponent[Rigidbody]() as RigidbodyComponent;

            // If there is no rigidbody continue
            if (!rigidbody)
                continue;

            //
            //  First pass for dynamic entities
            //

            // Store entities ordered by contact time
            let sortedEntities: SortedCollision[] = [];

            for (let j = i + 1; j < grid.dynamics.length; ++j) {
                // Get other dynamic entity rigidbody
                const otherRigidbody = grid.dynamics[j].entity.getComponent[Rigidbody]() as RigidbodyComponent;

                // If other entity does not has rigidbody continue
                if (!otherRigidbody)
                    continue;

                // Test collision against other entity
                const result = rigidbody.colide(otherRigidbody, deltaTime);

                if (result.intersect) {
                    sortedEntities.push({
                        other: otherRigidbody,
                        result: result
                    });

                    passResult.push({
                        caller: rigidbody,
                        other: grid.dynamics[j].entity,
                        result: result
                    });
                    passResult.push({
                        caller: otherRigidbody,
                        other: entity.entity,
                        result: result
                    });
                }
            }

            // Sorts based on contact time
            sortedEntities.sort((a, b) => {
                if (Math.abs(a.result.contactTime) <  Math.abs(b.result.contactTime))
                    return -1;
                if (Math.abs(a.result.contactTime) > Math.abs(b.result.contactTime))
                    return 1;
                return 0;
            });

            // Solves the collison
            sortedEntities.forEach(({ other, result }) => {
                // Fix for current entity
                rigidbody.velocity.x += result.contactNormal.x * Math.abs(rigidbody.velocity.x) * (1.0 - result.contactTime);
                rigidbody.velocity.y += result.contactNormal.y * Math.abs(rigidbody.velocity.y) * (1.0 - result.contactTime);

                // Fix for other entity
                other.velocity.x += (result.contactNormal.x * -1.0) * Math.abs(other.velocity.x) * (1.0 - result.contactTime);
                other.velocity.y += (result.contactNormal.y * -1.0) * Math.abs(other.velocity.y) * (1.0 - result.contactTime);
            });

            //
            //  Second pass for static cells
            //

            let sortedStatics: CollisionResult[] = [];

            // Check static neighbour
            for (let i = 0; i < 8; ++i) {
                const nx = entity.index.x + offsetX[i];
                const ny = entity.index.y + offsetY[i];

                if (nx < 0 || nx >= grid.width || ny < 0 || ny >= grid.height)
                    continue;
                
                const other = grid.statics[ny * grid.height + nx];

                if (!other)
                    continue;

                const result = rigidbody.colideStatic(other, deltaTime);

                if (result.intersect) {
                    sortedStatics.push(result);

                    passResult.push({
                        caller: rigidbody,
                        other: null,
                        result: result
                    });
                }
            }

            // Sorts based on contact time
            sortedStatics.sort((a, b) => {
                if (Math.abs(a.contactTime) <  Math.abs(b.contactTime))
                    return -1;
                if (Math.abs(a.contactTime) > Math.abs(b.contactTime))
                    return 1;
                return 0;
            });

            // Solves the collison
            sortedStatics.forEach((result) => {
                // Fix for current entity
                rigidbody.velocity.x += result.contactNormal.x * Math.abs(rigidbody.velocity.x) * (1.0 - result.contactTime);
                rigidbody.velocity.y += result.contactNormal.y * Math.abs(rigidbody.velocity.y) * (1.0 - result.contactTime);
            });
        }
    });
};

export { sysGridCollision, sysDispatchCollisions };
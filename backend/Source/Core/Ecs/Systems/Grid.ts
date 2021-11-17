// Math imports
import { Vec2 } from "../../../Utils/Math";

// Collision imports
import { CollisionResult } from "../../../Utils/Collisions";

// Components import
import { Rigidbody } from "../Components/Rigidbody";

// Interfaces
import { EcsData } from "../Interfaces";
import { Entity } from "../Core/Ecs";

interface SortedCollision {
    other: Rigidbody;
    result: CollisionResult;
}

// For neighbor checks
const offsetX = [ -1,  0,  1,  1,  1,  0, -1, -1];
const offsetY = [ -1, -1, -1,  0,  1,  1,  1,  0];

const sys_UpdateGrid = (data: EcsData, deltaTime: number): void => {
    // Iterates through all grids in system
    data.grids.forEach((grid) => {
        // Just dynamics entitys should be checked
        grid.dynamics.forEach((dynamic) => {
            const transform = dynamic.entity.getTransform();

            // Changes coordinate sistem from ndc to normalized left-upper origin
            const position = transform.pos.adds(1.0).divs(2.0);
            position.y = 1 - position.y;

            // Find new index of entity
            const index = new Vec2(
                Math.floor(position.x / (grid.intervalX / 2.0)),
                Math.floor(position.y / (grid.intervalY / 2.0)),
            );

            // Update the index in the definition
            dynamic.index = index;
        });
    });
};

interface CollisionPair {
    entity: Entity;
    other: Entity;
}

let collisionsResults: CollisionPair[] = [];

const sys_CheckCollisions = (data: EcsData, deltaTime: number): void => {
    data.grids.forEach((grid) => {

        grid.dynamics.map((dynamic) => {
            const behavior = dynamic.entity.getBehavior();

            behavior.colliding = [];
        });

        collisionsResults.map((collision) => {
            if (collision.entity.destroyed || collision.other.destroyed)
                return;
            const behavior = collision.entity.getBehavior();
            const otherBehavior = collision.other.getBehavior();

            behavior.colliding.push(collision.other);
            otherBehavior.colliding.push(collision.entity);
        });

        collisionsResults = [];
    });
}

const sys_UpdateCollisions = (data: EcsData, deltaTime: number): void => {
    data.grids.forEach((grid) => {

        for (let i = 0; i < grid.dynamics.length; ++i) {

            // Current dynamic entity data
            const entity = grid.dynamics[i].entity;
            const index = grid.dynamics[i].index;

            // Get current dynamic entity rigidbody
            const rigidbody = entity.getRigidbody();

            //
            //  First pass for dynamic entities
            //

            // Store entities ordered by contact time
            let sortedEntities: SortedCollision[] = [];

            for (let j = i + 1; j < grid.dynamics.length; ++j) {
                // Get other dynamic entity rigidbody
                const otherRigidbody = grid.dynamics[j].entity.getRigidbody();

                // Test collision against other entity
                const result = rigidbody.colide(otherRigidbody, deltaTime);

                if (result.intersect) {
                    collisionsResults.push({
                        entity: entity,
                        other: grid.dynamics[j].entity
                    });
                    sortedEntities.push({
                        other: otherRigidbody,
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
                // Stop both entities if colliding perfect in horizontal
                if (result.contactNormal.x == 0 && result.contactNormal.y == 0) {
                    rigidbody.velocity.x = 0;
                    rigidbody.velocity.y = 0;
                    other.velocity.x = 0;
                    other.velocity.y = 0;
                }

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
                const nx = index.x + offsetX[i];
                const ny = index.y + offsetY[i];

                if (nx < 0 || nx >= grid.width || ny < 0 || ny >= grid.height)
                    continue;
                
                const other = grid.statics[ny * grid.height + nx];

                if (!other)
                    continue;

                const result = rigidbody.colideStatic(other, deltaTime);

                if (result.intersect) {
                    sortedStatics.push(result);
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
                if (result.contactNormal.x == 0 && result.contactNormal.y == 0) {
                    rigidbody.velocity.x = 0;
                    rigidbody.velocity.y = 0;
                }
                // Fix for current entity
                rigidbody.velocity.x += result.contactNormal.x * Math.abs(rigidbody.velocity.x) * (1.0 - result.contactTime);
                rigidbody.velocity.y += result.contactNormal.y * Math.abs(rigidbody.velocity.y) * (1.0 - result.contactTime);
            });
        }
    });
}

export { sys_UpdateGrid, sys_UpdateCollisions, sys_CheckCollisions };
// Math imports
import { Vec2 } from "../../../Utils/Math";

// Collision imports
import { CollisionResult } from "../../../Utils/Collisions";

// Components import
import { Rigidbody } from "../Components/Rigidbody";

// Interfaces
import { EcsData } from "../Interfaces";
import { Entity } from "../Core/Ecs";
import { Rectangle } from "../Components/Rectangle";

interface SortedCollision {
    other: Rigidbody;
    result: CollisionResult;
}

interface SortedStatic {
    other: Rectangle;
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
            const rectangle = dynamic.entity.getRectangle();
            // Changes coordinate sistem from ndc to normalized left-upper origin
            const position = transform.pos.adds(1.0).divs(2.0);
            position.y = 1 - position.y;

            // Find new index of entity
            const index = new Vec2(
                Math.floor(position.x / (grid.intervalX / 2.0)),
                Math.floor(position.y / (grid.intervalY / 2.0)),
            );

            const index1 = new Vec2(
                Math.floor((position.x - (rectangle.width / 4.0)) / (grid.intervalX / 2.0)),
                Math.floor((position.y - (rectangle.height / 4.0)) / (grid.intervalY / 2.0)),
            );
    
            const index2 = new Vec2(
                Math.floor((position.x + (rectangle.width / 4.0)) / (grid.intervalX / 2.0)),
                Math.floor((position.y + (rectangle.height / 4.0)) / (grid.intervalY / 2.0)),
            );
            
            // Update the index in the definition
            dynamic.index = index;

            dynamic.ocupations = [];

            dynamic.ocupations = [
                index1,
                new Vec2(index2.x, index1.y),
                new Vec2(index1.x, index2.y),
                index2
            ];
        });
    });
};

interface CollisionPair {
    entity: Entity;
    other: Entity;
}

interface StaticCollisionPair {
    entity: Entity;
    normal: Vec2;
    center: Vec2;
}

let collisionsResults: CollisionPair[] = [];
let staticColide: StaticCollisionPair[] = [];

const sys_CheckCollisions = (data: EcsData, deltaTime: number): void => {
    data.grids.forEach((grid) => {

        grid.dynamics.map((dynamic) => {
            const behavior = dynamic.entity.getBehavior();

            behavior.colliding = [];
            dynamic.entity.getBehavior().staticColide = false;
            dynamic.entity.getBehavior().staticNormal = new Vec2();
            dynamic.entity.getBehavior().staticCenter = new Vec2();
        });

        collisionsResults.map((collision) => {
            if (collision.entity.destroyed || collision.other.destroyed)
                return;
            const behavior = collision.entity.getBehavior();
            const otherBehavior = collision.other.getBehavior();

            behavior.colliding.push(collision.other);
            otherBehavior.colliding.push(collision.entity);
        });

        staticColide.map((collision) => {
            collision.entity.getBehavior().staticColide = true;
            collision.entity.getBehavior().staticNormal = collision.normal;
            collision.entity.getBehavior().staticNormal = collision.center;
        });

        collisionsResults = [];
        staticColide = [];
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
                // Fix for current entity
                rigidbody.velocity.x += result.contactNormal.x * Math.abs(rigidbody.velocity.x) * (1.0 - result.contactTime);
                rigidbody.velocity.y += result.contactNormal.y * Math.abs(rigidbody.velocity.y) * (1.0 - result.contactTime);

                // Fix for other entity
                other.velocity.x += (result.contactNormal.x * -1.0) * Math.abs(other.velocity.x) * (1.0 - result.contactTime);
                other.velocity.y += (result.contactNormal.y * -1.0) * Math.abs(other.velocity.y) * (1.0 - result.contactTime);

                // Stop both entities if colliding perfect in horizontal
                if (result.contactNormal.x == 0 && result.contactNormal.y == 0) {
                    rigidbody.velocity.x = 0.0001;
                    rigidbody.velocity.y = 0.0001;
                    other.velocity.x = 0.0001;
                    other.velocity.y = 0.0001;
                }
            });

            //
            //  Second pass for static cells
            //

            let sortedStatics: SortedStatic[] = [];

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
                    console.log("Entidade", entity);
                    console.log("Colidiu com estatico: ", other.getCenter())
                    sortedStatics.push({
                        other: other,
                        result: result
                    });
                }
            }

            // Sorts based on contact time
            sortedStatics.sort((a, b) => {
                if (Math.abs(a.result.contactTime) <  Math.abs(b.result.contactTime))
                    return -1;
                if (Math.abs(a.result.contactTime) > Math.abs(b.result.contactTime))
                    return 1;
                return 0;
            });

            if (sortedStatics.length != 0) {
                staticColide.push({
                    entity: entity,
                    normal: sortedStatics[0].result.contactNormal,
                    center: sortedStatics[0].other.getCenter()
                });
            }

            // Solves the collison
            sortedStatics.forEach((result) => {
                // Fix for current entity
                rigidbody.velocity.x += (result.result.contactNormal.x * Math.abs(rigidbody.velocity.x) * (1.0 - result.result.contactTime)) * 1.001;
                rigidbody.velocity.y += (result.result.contactNormal.y * Math.abs(rigidbody.velocity.y) * (1.0 - result.result.contactTime)) * 1.001;
                if (result.result.contactNormal.x == 0 && result.result.contactNormal.y == 0) {
                    rigidbody.velocity.x = 0;
                    rigidbody.velocity.y = 0;
                }
            });
        }

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
                // Fix for current entity
                rigidbody.velocity.x += result.contactNormal.x * Math.abs(rigidbody.velocity.x) * (1.0 - result.contactTime);
                rigidbody.velocity.y += result.contactNormal.y * Math.abs(rigidbody.velocity.y) * (1.0 - result.contactTime);

                // Fix for other entity
                other.velocity.x += (result.contactNormal.x * -1.0) * Math.abs(other.velocity.x) * (1.0 - result.contactTime);
                other.velocity.y += (result.contactNormal.y * -1.0) * Math.abs(other.velocity.y) * (1.0 - result.contactTime);

                // Stop both entities if colliding perfect in horizontal
                if (result.contactNormal.x == 0 && result.contactNormal.y == 0) {
                    rigidbody.velocity.x = 0;
                    rigidbody.velocity.y = 0;
                    other.velocity.x = 0;
                    other.velocity.y = 0;
                }
            });

        }
    });
}

export { sys_UpdateGrid, sys_UpdateCollisions, sys_CheckCollisions };
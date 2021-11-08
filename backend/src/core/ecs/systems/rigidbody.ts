import { EcsData } from "../../interfaces";

const sysUpdatePos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all rigidbodys in system
    data.rigidbodys.forEach((rigidbody) => {
        let transform = rigidbody.rectangle.transform;

        transform.pos.x += rigidbody.velocity.x * deltaTime;
        transform.pos.y += rigidbody.velocity.y * deltaTime;
    });
};

export { sysUpdatePos };
import { RectangleComponent } from "./rectangle";

class RigidbodyComponent {

    velocity: Vec2;

    rectangle: RectangleComponent;

    constructor(rectangle: RectangleComponent) {
        this.rectangle = rectangle;
        this.velocity = new Vec2();
    }

    colide(other: RigidbodyComponent): void {

    }

}

export { RigidbodyComponent };

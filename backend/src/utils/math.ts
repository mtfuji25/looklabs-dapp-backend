
class Vec2 {

    x: number;
    y: number;

    constructor(x: number = 0.0, y: number = 0.0) {
        this.x = x;
        this.y = y;
    }

    add(ohter: Vec2): Vec2 {
        return new Vec2(
            this.x + ohter.x,
            this.y + ohter.y
        );
    }

    adds(ohter: number): Vec2 {
        return new Vec2(
            this.x + ohter,
            this.y + ohter
        );
    }

    sub(ohter: Vec2): Vec2 {
        return new Vec2(
            this.x - ohter.x,
            this.y - ohter.y
        );
    }

    subs(ohter: number): Vec2 {
        return new Vec2(
            this.x - ohter,
            this.y - ohter
        );
    }

    mul(ohter: Vec2): Vec2 {
        return new Vec2(
            this.x * ohter.x,
            this.y * ohter.y
        );
    }

    muls(ohter: number): Vec2 {
        return new Vec2(
            this.x * ohter,
            this.y * ohter
        );
    }

    div(ohter: Vec2): Vec2 {
        return new Vec2(
            this.x / ohter.x,
            this.y / ohter.y
        );
    }

    divs(ohter: number): Vec2 {
        return new Vec2(
            this.x / ohter,
            this.y / ohter
        );
    }

    equal(other: Vec2): boolean {
        return this.x == other.x && this.y == other.y;
    }

    dot(ohter: Vec2): number {
        return this.x * ohter.x + this.y * ohter.y;
    }

    length(): number {
        return Math.sqrt(this.dot(this));
    }

    squareLength(): number {
        return this.dot(this);
    }

    normalize(): Vec2 {
        return this.muls(1.0 / this.length());
    }

}

const deg2rad = (deg: number): number => {
    return deg * (Math.PI / 180.0);
}

const rad2deg = (rad: number): number => {
    return rad * (180.0 / Math.PI);
}

const lerp = (a: number, b: number, t: number): number => {
    return (1 - t) * a + t * b;
}

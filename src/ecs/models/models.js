import * as PIXI from "pixi.js";

class TilingSprite {
    constructor(transform) {
        this.img = {};
        this.transform = transform;
        this.sprite = new PIXI.TilingSprite();
        this.sprite.x = transform.pos.x;
        this.sprite.y = transform.pos.y;
        this.sprite.anchor.set(0.0);
    }

    setImg(img) {
        this.img = img;
        this.sprite.texture = img.texture;
    }

    addStage(app) {
        app.stage.addChild(this.sprite);
    }

    removeStage(app) {
        app.stage.removeChild(this.sprite);
    }

    setScale(x, y) {
        this.sprite.scale.x = x;
        this.sprite.scale.y = y;
    }

    update() {
        this.sprite.x = this.transform.pos.x;
        this.sprite.y = this.transform.pos.y;
    }
}

class AnimatedSprite {
    constructor(transform) {
        this.transform = transform;
    }

    update() {

    }
};

class Sprite {
    constructor(transform) {
        this.img = {};
        this.transform = transform;
        this.sprite = new PIXI.Sprite();
        this.sprite.x = transform.pos.x;
        this.sprite.y = transform.pos.y;
    }

    setImg(img) {
        this.img = img;
        this.sprite.texture = img.texture;
    }

    addStage(app) {
        app.stage.addChild(this.sprite);
    }

    removeStage(app) {
        app.stage.removeChild(this.sprite);
    }

    setScale(x, y) {
        this.sprite.scale.x = x;
        this.sprite.scale.y = y;
    }

    update() {
        this.sprite.x = this.transform.pos.x;
        this.sprite.y = this.transform.pos.y;
    }
};

class Rectangle {
    constructor(transform) {
        this.transform = transform;
        this.width = 0.0;
        this.height = 0.0;
    }

    update() {
        
    }
};

class RigidBody {
    constructor(transform) {
        this.transform = transform;
        this.velocity = {
            x: 0,
            y: 0,
        };
        this.acceleration = {
            x: 0,
            y: 0,
        };
    }

    addVel(x, y) {
        this.velocity.x += x;
        this.velocity.y += y;
    }

    update() {
        
    }
};

class Transform {
    constructor(x, y, scaleX = 1.0, scaleY = 1.0, angle = 0.0) {
        this.pos = {
            x: x,
            y: y,
        };

        this.scale = {
            x: scaleX,
            y: scaleY,
        }

        this.angle = angle;
    }

    translate(x, y) {
        this.pos.x += x;
        this.pos.y += y;
    }

    rotate(angle) {
        this.angle += angle;
    }

    update() {
        
    }
}


export { Transform, Rectangle, RigidBody, Sprite, AnimatedSprite, TilingSprite };
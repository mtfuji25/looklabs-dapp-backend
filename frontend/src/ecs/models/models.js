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
        this.ssheet = {};
        this.sprites = {};
        this.sprite = {};
        this.transform = transform;
        this.texWidth = 0;
        this.texHeight = 0;
        this.frameWidth = 0;
        this.frameHeight = 0;
    }

    loadFromConfig(app, config) {
        this.ssheet = new PIXI.BaseTexture.from(app.loader.resources[config["resource"]].url);
        this.texWidth = config["texWidth"];
        this.texHeight = config["texHeight"];
        this.frameWidth = config["frameWidth"];
        this.frameHeight = config["frameHeigth"];
        
        config["animations"].forEach((animation) => {
            this.sprites[animation] = [];
            config[animation].forEach((frame) => {
                this.sprites[animation].push(
                    new PIXI.Texture(this.ssheet, new PIXI.Rectangle(frame[1] * this.frameWidth, frame[0] * this.frameHeight, this.frameWidth, this.frameHeight))
                );
            });
        });

        this.sprite = new PIXI.AnimatedSprite(this.sprites[config["animations"][0]]);
        this.sprite.animationSpeed = config["speed"];
        this.sprite.loop = config["loop"];

        this.sprite.anchor.set(0.5);
        this.sprite.x = this.transform.pos.x;
        this.sprite.y = this.transform.pos.y;
    }

    animate(animation) {
        if (!this.sprite.playing) {
            this.sprite.textures = this.sprites[animation];
            this.sprite.play();
        }
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

class Sprite {
    constructor(transform) {
        this.img = {};
        this.transform = transform;
        this.sprite = new PIXI.Sprite();
        this.sprite.x = transform.pos.x;
        this.sprite.y = transform.pos.y;
        this.sprite.anchor.set(0.5);
    }

    setCustomImg(img, w, h, pw, ph) {
        let ssheet = new PIXI.BaseTexture.from(img.url);
        let texture = new PIXI.Texture(ssheet, new PIXI.Rectangle(pw, ph, w, h));
        this.sprite.texture = texture;
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
        this.needCheck = false;
    }

    getBounds() {
        return {
            minX: this.transform.pos.x - this.width / 2.0,
            maxX: this.transform.pos.x + this.width / 2.0,
            minY: this.transform.pos.y - this.height / 2.0,
            maxY: this.transform.pos.y + this.height / 2.0,
        };
    }

    checkCollision(rec) {
        let a = this.getBounds();
        let b = rec.getBounds();

        return (a.minX <= b.maxX && a.maxX >= b.minX) &&
               (a.minY <= b.maxY && a.maxY >= b.minY) 
    }

    update() {}
};

class RigidBody {
    constructor(transform) {
        this.transform = transform;
        this.mass = 0.0;
        this.velocity = {
            x: 0,
            y: 0,
        };
        this.acceleration = {
            x: 0,
            y: 0,
        };
    }

    addInpulse(x, y, duration) {
        let difX = (duration * x) / this.mass;
        let difY = (duration * y) / this.mass;

        this.velocity.x += difX;
        this.velocity.y += difY;
    }

    addVel(x, y) {
        this.velocity.x += x;
        this.velocity.y += y;
    }

    update() {}
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

    update() {}
}


export { Transform, Rectangle, RigidBody, Sprite, AnimatedSprite, TilingSprite };
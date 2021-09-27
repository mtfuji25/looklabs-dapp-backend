//
//  Assets directories
//

const ICON_DIR = "../assets/icons/";
const IMAGE_DIR = "../assets/images/";
const SPRITE_DIR = "../assets/sprites/";
const SPRITESHEET_DIR = "../assets/spritesheets/";
const BGPACK_DIR = "../assets/bg-pack/"


const resources = {
    "bg-pack": [
        { "name": "bg1", "url": "../assets/bg-pack/bg-back.png" },
        { "name": "bg2", "url": "../assets/bg-pack/bg-clouds.png" },
        { "name": "bg3", "url": "../assets/bg-pack/bg-trees3.png" },
        { "name": "bg4", "url": "../assets/bg-pack/bg-trees2.png" },
        { "name": "bg5", "url": "../assets/bg-pack/bg-trees1.png" },
        { "name": "bg6", "url": "../assets/bg-pack/bg-terrain.png" }
    ],
    "ui-pack": [
        { "name": "lifebar", "url": "../assets/ui-pack/teste.png" }
    ],
    "player-pack": [
        { "name": "player", "url": "../assets/player-pack/player.png" },
        { "name": "shots", "url": "../assets/player-pack/shots.png" }
    ]
}

//  Constants
const ROOT_DIV = document.querySelector("#root");

//  Physical constants
const GRAVITY = 9.81;

//  In game used key codes

const KEY_CODE = {
    KEY_W: 87,
    KEY_S: 83,
    KEY_A: 65,
    KEY_D: 68,
    KEY_ESC: 27,
    KEY_SPACE: 32
};

const MOUSE_CODE = {
    MOUSE_LEFT: 0,
    MOUSE_MIDDLE: 1,
    MOUSE_RIGTH: 2,
};

//
//  Data containers
//

//  Represent the current state of the key
//  true == down  /  false == up
const input = {
    key: {},
    btn: {},
    cursorPos: { x: 0, y: 0 }
}

//  Parallax background data
const background = {
    layers: [],
    number: 6,
    texWidth: 560,
    texHeight: 315,
    parallax: 1.5,
    currentX: 0.0,
    terrainFactor: 0.86984
}

const world = {
    down: 0.0,
    up: 0.0,
    width: 0.0,
    height: 0.0
}

const PLAYER_MOVES = {
    RIGHT: 0,
    LEFT: 1,
    SHOT_RIGHT: 2,
    SHOT_LEFT: 3
}

const player = {
    sheet: {},
    shotSheet: {},
    sprite: {},
    shotSprite: {},
    texWidth: 492,
    texHeight: 400,
    shotWidth: 492,
    shotHeight: 200,
    sheetWidth: 82,
    sheetHeight: 100,
    right: true,
    velocityY: 0.0,
    jumping: false,
    shoting: false,
}

//
//  Handled by PIXI
//
const handlePointerMove = (event) => {
    let pos = event.data.global;

    input.cursorPos.x = pos.x;
    input.cursorPos.y = pos.y;
}

//
//  Handled by default browser event system
//

//  When some key is pressed down
const handleKeyDown = (event) => {
    input.key[event.keyCode] = true;
};

//  When some key is released up
const handleKeyUp = (event) => {
    input.key[event.keyCode] = false;
};

//  When some button is pressed down
const handleMouseBtnDown = (event) => {
    input.btn[event.button] = true;
};

//  When some button is released up
const handleMouseBtnUp = (event) => {
    input.btn[event.button] = false;
};

//  When mouse wheel is activated
const handleMouseWheel = (event) => {
    let up = (event.wheelDelta > 0) ? true : false;
};

//  Software entry point
window.onload = () => {
    
    //  Create a PIXI application
    let app = new PIXI.Application({
        resolution: devicePixelRatio,
        backgroundColor: 0xAAAAAA,
        resizeTo: ROOT_DIV
    });

    //  Attach the app view to root div in index.html
    ROOT_DIV.appendChild(app.view);

    app.loader
        .add(resources["bg-pack"])
        .add(resources["ui-pack"])
        .add(resources["player-pack"]);

    app.loader.onComplete.add(() => {
        initLevel(app);
    });
    app.loader.load();

    // Allow the interactive mode of PIXI
    app.stage.interactive = true;

    // Set the PIXI event listener
    app.stage.on("pointermove", handlePointerMove);

    // Remove the default behavior of browser of open contextmenu
    // when right mouse button is pressed on page
    document.addEventListener("contextmenu", (event) => {
        event.preventDefault();
    }, false);

    // Set the browser event listeners
    window.addEventListener("keydown", handleKeyDown);
    window.addEventListener("keyup", handleKeyUp);
    window.addEventListener("mousedown", handleMouseBtnDown);
    window.addEventListener("mouseup", handleMouseBtnUp);
    window.addEventListener("wheel", handleMouseWheel);
};

//
//  Parallax Background functions
//

const initWorld = (app) => {
    world.width = app.view.width;
    world.height = app.view.height;
    world.down = (app.view.height - (app.view.height * background.terrainFactor));
    world.up = app.view.height;
}

const createBg = (texture, app) => {
    let tiling = new PIXI.TilingSprite(texture, app.view.width, app.view.height);
    tiling.position.set(0.0);

    let factorX = app.view.width / background.texWidth;
    let factorY = app.view.height / background.texHeight;

    tiling.tileScale.x = factorX;
    tiling.tileScale.y = factorY;
    app.stage.addChild(tiling);

    return tiling;
};

const initBg = (app) => {
    for (i = 1; i <= background.number; ++i) {
        background.layers.push(createBg(app.loader.resources[`bg${i}`].texture, app));
    }
};

const updateBg = () => {
    if (input.key[KEY_CODE.KEY_A])
        background.currentX += background.parallax;
    else if (input.key[KEY_CODE.KEY_D])
        background.currentX -= background.parallax;

    background.layers[0].tilePosition.x = background.currentX / 6;
    background.layers[1].tilePosition.x = background.currentX / 5;
    background.layers[2].tilePosition.x = background.currentX / 4;
    background.layers[3].tilePosition.x = background.currentX / 3;
    background.layers[4].tilePosition.x = background.currentX / 2;
    background.layers[5].tilePosition.x = background.currentX / 1;
};

const initPlayer = (app) => {
    let ssheet = new PIXI.BaseTexture.from(app.loader.resources["player"].url);
    let shotSshet = new PIXI.BaseTexture.from(app.loader.resources["shots"].url);
    let w = player.sheetWidth;
    let h = player.sheetHeight;

    player.sheet["right"] = [
        new PIXI.Texture(ssheet, new PIXI.Rectangle(0, 0, w, h))
    ];

    player.sheet["left"] = [
        new PIXI.Texture(ssheet, new PIXI.Rectangle(0, h, w, h))
    ];

    player.sheet["walkright"] = [
        new PIXI.Texture(ssheet, new PIXI.Rectangle(0 * w, 0, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(1 * w, 0, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(2 * w, 0, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(3 * w, 0, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(4 * w, 0, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(5 * w, 0, w, h)),
    ]

    player.sheet["walkleft"] = [
        new PIXI.Texture(ssheet, new PIXI.Rectangle(0 * w, h, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(1 * w, h, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(2 * w, h, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(3 * w, h, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(4 * w, h, w, h)),
        new PIXI.Texture(ssheet, new PIXI.Rectangle(5 * w, h, w, h)),
    ]

    player.shotSheet["shotright"] = [
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(0 * w, 0, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(1 * w, 0, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(2 * w, 0, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(3 * w, 0, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(4 * w, 0, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(5 * w, 0, w, h)),
    ]

    player.shotSheet["shotleft"] = [
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(0 * w, h, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(1 * w, h, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(2 * w, h, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(3 * w, h, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(4 * w, h, w, h)),
        new PIXI.Texture(shotSshet, new PIXI.Rectangle(5 * w, h, w, h)),
    ]

    player.sprite = new PIXI.AnimatedSprite(player.sheet["right"]);
    player.sprite.animationSpeed = 0.5;
    player.sprite.loop = false;

    player.sprite.anchor.set(1.0);
    player.sprite.x = app.view.width / 2;
    player.sprite.y = Math.round(app.view.height - world.down) + 1;

    player.shotSprite = new PIXI.AnimatedSprite(player.shotSheet["shotright"]);
    player.shotSprite.animationSpeed = 1.0;
    player.shotSprite.loop = false;
    player.shotSprite.visible = false;

    player.shotSprite.anchor.set(1.0);
    player.shotSprite.x = app.view.width / 2;
    player.shotSprite.y = Math.round(app.view.height - world.down) + 1;

    player.shotSprite.onComplete = () => {
        player.shoting = false;
        player.shotSprite.visible = false;
    }

    app.stage.addChild(player.sprite);
    app.stage.addChild(player.shotSprite);
}

const playerJump = () => {
    if (!player.jumping) {
        player.velocityY = 5.0;
        player.jumping = true;
    }
}

const updatePlayerJump = () => {
    if (player.jumping) {
        player.sprite.y = Math.round(player.sprite.y - player.velocityY);
        player.velocityY -= GRAVITY * 0.030
    }
    if (player.sprite.y >= Math.round(world.height - world.down) + 1) {
        velocityY = 0.0;
        player.jumping = false;
    }
    player.shotSprite.y = player.sprite.y;
}

const updatePlayer = () => {
    if (input.key[KEY_CODE.KEY_A])
    {
        if (!player.sprite.playing) {
            player.sprite.textures = player.sheet["walkleft"];
            player.sprite.play();
        }
        player.right = false;
        player.sprite.x -= 2;
    } else if (input.key[KEY_CODE.KEY_D])
    {
        if (!player.sprite.playing) {
            player.sprite.textures = player.sheet["walkright"];
            player.sprite.play();
        }
        player.right = true;
        player.sprite.x += 2;
    }

    if (input.key[KEY_CODE.KEY_SPACE])
    {
        playerJump();
    }
    player.shotSprite.x = player.sprite.x;

    if (input.btn['0']) {
        player.shoting = true;
        player.shotSprite.visible = true;
    }

    if (player.shoting) {
        if (!player.shotSprite.playing && player.right) {
            player.shotSprite.textures = player.shotSheet["shotright"];
            player.shotSprite.play();
        }
        if ((!player.shotSprite.playing) && (!player.right)) {
            player.shotSprite.textures = player.shotSheet["shotleft"];
            player.shotSprite.play();
        }
    }

    updatePlayerJump();
}

const updateShot = () => {

}

//
//  Main game loop and level initialization
//

const initLevel = (app) => {
    initBg(app);
    initWorld(app);
    initPlayer(app);
    app.ticker.add(gameLoop);
};

const gameLoop = () => {
    console.log(`PosX: ${input.cursorPos.x}, PosY: ${input.cursorPos.y}`);
    updateBg();
    updatePlayer();
};

//
//  Collisions, physics and utils ...
//

const sysUpdateAcceleration = (entity) => {
    
};

const sysUpdateVelocity = (entity) => {

};

const sysUpdatePosition = (entity) => {

};

const sysUpdateGravity = (entity) => {

};

const sysUpdateCollision = (entity) => {

};

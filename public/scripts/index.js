//
//  Assets directories
//

const ICON_DIR = "../assets/icons/";
const IMAGE_DIR = "../assets/images/";
const SPRITE_DIR = "../assets/sprites/";
const SPRITESHEET_DIR = "../assets/spritesheets/";
const BGPACK_DIR = "../assets/bg-pack/"


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
    MOUSE_RIGTH: 2,
    MOUSE_MIDDLE: 1
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

const bg = {
    bgBack: {},
    bgClouds: {},
    bgTrees3: {},
    bgTrees2: {},
    bgTrees1: {},
    bgTerrain: {},
    speed: 0.5,
    bgX: 0.0
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
        .add("bg-back", BGPACK_DIR + "bg-back.png")
        .add("bg-clouds", BGPACK_DIR + "bg-clouds.png")
        .add("bg-trees3", BGPACK_DIR + "bg-trees3.png")
        .add("bg-trees2", BGPACK_DIR + "bg-trees2.png")
        .add("bg-trees1", BGPACK_DIR + "bg-trees1.png")
        .add("bg-terrain", BGPACK_DIR + "bg-terrain.png")

    app.loader.onComplete.add(() => {
        initLevel(app);
    });
    app.loader.load();

    // let player = new PIXI.Sprite.from(SPRITE_DIR + "mage.png");
    // player.anchor.set(0.5);
    // player.x = app.view.width / 2;
    // player.y = app.view.height / 2;

    // app.loader.add("lifebar", SPRITESHEET_DIR + "lifebar.png");

    // app.stage.addChild(player);

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

const createBg = (texture, app) => {
    let tiling = new PIXI.TilingSprite(texture, app.view.width, app.view.height);
    tiling.position.set(0.0);
    let scaleFactorX = app.view.width / 560.0;
    let scaleFactorY = app.view.height / 315.0;
    tiling.tileScale.x = scaleFactorX;
    tiling.tileScale.y = scaleFactorY;
    app.stage.addChild(tiling);

    return tiling;
}

const initBg = (app) => {
    bg.bgBack = createBg(app.loader.resources["bg-back"].texture, app);
    bg.bgClouds = createBg(app.loader.resources["bg-clouds"].texture, app);
    bg.bgTrees3 = createBg(app.loader.resources["bg-trees3"].texture, app);
    bg.bgTrees2 = createBg(app.loader.resources["bg-trees2"].texture, app);
    bg.bgTrees1 = createBg(app.loader.resources["bg-trees1"].texture, app);
    bg.bgTerrain = createBg(app.loader.resources["bg-terrain"].texture, app);
}

const initLevel = (app) => {
    initBg(app);
    app.ticker.add(gameLoop);
}

//
//  Main game loop
//

const gameLoop = () => {
    console.log(`PosX: ${input.cursorPos.x}, PosY: ${input.cursorPos.y}`);
    sysUpdateBg();
}

//
//  Collisions, physics and utils ...
//

const sysUpdateBg = () => {
    bg.bgX = (bg.bgX + bg.speed);

    bg.bgBack.tilePosition.x = bg.bgX / 5;
    bg.bgClouds.tilePosition.x = bg.bgX / 4;
    bg.bgTrees3.tilePosition.x = bg.bgX / 3;
    bg.bgTrees2.tilePosition.x = bg.bgX / 2;
    bg.bgTrees1.tilePosition.x = bg.bgX;
    bg.bgTerrain.tilePosition.x = bg.bgX;
}

const sysUpdateAcceleration = (entity) => {
    
}

const sysUpdateVelocity = (entity) => {

}

const sysUpdatePosition = (entity) => {

}

const sysUpdateGravity = (entity) => {

}

const sysUpdateCollision = (entity) => {

}
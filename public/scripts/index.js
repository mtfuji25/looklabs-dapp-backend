//
//  Assets directories
//

const LOADER_BASEURL = "../assets/"

const ICON_DIR = "../assets/icons/";
const IMAGE_DIR = "../assets/images/";
const SPRITE_DIR = "../assets/sprites/";
const SPRITESHEET_DIR = "../assets/spritesheets/";

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

const parallaxBackground = {

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

    let player = new PIXI.Sprite.from(SPRITE_DIR + "mage.png");
    player.anchor.set(0.5);
    player.x = app.view.width / 2;
    player.y = app.view.height / 2;

    app.loader.add("lifebar", SPRITESHEET_DIR + "lifebar.png");

    app.stage.addChild(player);

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
//  Main game loop
//

const gameLoop = () => {
    console.log(`PosX: ${input.cursorPos.x}, PosY: ${input.cursorPos.y}`);
}

//
//  Collisions, physics and utils ...
//

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
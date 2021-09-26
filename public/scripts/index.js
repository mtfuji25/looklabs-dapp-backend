//
//  Assets directories
//

const ICON_DIR = "../assets/icons/";
const IMAGE_DIR = "../assets/images/";
const SPRITE_DIR = "../assets/sprites/";

//  Constants
const ROOT_DIV = document.querySelector("#root");

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
let keyState = {};
let btnState = {};

//
//  Handled by PIXI
//
const handlePointerMove = (event) => {
    
}

//
//  Handled by default browser event system
//

//  When some key is pressed down
const handleKeyDown = (event) => {
    keyState[event.keyCode] = true;
};

//  When some key is released up
const handleKeyUp = (event) => {
    keyState[event.keyCode] = false;
};

//  When some button is pressed down
const handleMouseBtnDown = (event) => {
    btnState[event.button] = true;
};

//  When some button is released up
const handleMouseBtnUp = (event) => {
    btnState[event.button] = false;
};

//  When mouse wheel is activated
const handleMouseWheel = (event) => {
    let up = (event.wheelDelta > 0) ? true : false;

    
};

//  Software entry point
window.onload = () => {
    let app = new PIXI.Application({
        resolution: devicePixelRatio,
        backgroundColor: 0xAAAAAA,
        resizeTo: ROOT_DIV
    });

    ROOT_DIV.appendChild(app.view);

    let player = new PIXI.Sprite.from(SPRITE_DIR + "mage.png");
    player.anchor.set(0.5);
    player.x = app.view.width / 2;
    player.y = app.view.height / 2;

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

    app.ticker.add(gameLoop);
};

//
//  Main game loop
//

const gameLoop = () => {
    console.log(keyState);
    console.log(btnState);
}
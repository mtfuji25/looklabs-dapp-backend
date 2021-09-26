const SPRITE_DIR = "../assets/sprites/";

window.onload = () => {
    let app = new PIXI.Application({
        width: innerWidth - 10,
        height: innerHeight - 10,
        resolution: devicePixelRatio,
        backgroundColor: 0xAAAAAA
    });

    document.querySelector("#root").appendChild(app.view);

    let player = new PIXI.Sprite.from(SPRITE_DIR + "mage.png");
    player.anchor.set(0.5);
    player.x = app.view.width / 2;
    player.y = app.view.height / 2;

    app.stage.addChild(player);

    app.stage.interactive = true;

    app.stage.on("pointermove", (e) => {
        let pos = e.data.global;

        player.x = pos.x;
        player.y = pos.y;
    })

};
import { Text } from "./Components/Text";
import { Sprite } from "./Components/Sprite";
import { Transform } from "./Components/Transform";
import { AnimSprite } from "./Components/AnimSprite";
import { ColoredRectangle } from "./Components/ColoredRectangle";

interface EcsData {
    texts: Text[];
    sprites: Sprite[];
    transforms: Transform[];
    animsprites: AnimSprite[];
    coloredRecs: ColoredRectangle[];
}

export { EcsData };
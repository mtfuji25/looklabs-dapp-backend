import { Text } from "./Components/Text";
import { Sprite } from "./Components/Sprite";
import { Transform } from "./Components/Transform";
import { AnimSprite } from "./Components/AnimSprite";

interface EcsData {
    texts: Text[];
    sprites: Sprite[];
    transforms: Transform[];
    animsprites: AnimSprite[];
}

export { EcsData };
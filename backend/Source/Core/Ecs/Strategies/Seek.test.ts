import { GridUtils } from "../../../Utils/GridUtils";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { ECS } from "../Core/Ecs";
import { strategy_SeekNearest } from "./Seek";

describe("Seek", () => {
    describe("strategy_SeekNearest", () => {
        test("Test 1", () => {
            // Mock functions
            GridUtils.getCellWalkable = () => 0;
            GridUtils.finder.findPath = (_, __) => [
                [0, 0],
                [1, 0],
                [2, 0],
                [2, 1],
                [2, 2]
            ];

            const grid = new Grid(5, 5);
            const ecs = new ECS();

            const entityPos = GridUtils.convertCellToPos(new Vec2(0, 0), grid);
            const targetPos = GridUtils.convertCellToPos(new Vec2(2, 2), grid);

            const entity = ecs.createEntity(entityPos.x, entityPos.y, "entity", 1);
            const target = ecs.createEntity(targetPos.x, targetPos.y, "target", 2);

            grid.addDynamic(entity);
            grid.addDynamic(target);

            const oldVelocity = entity.getRigidbody().velocity;

            // Needed to add speed to the entity to be able to move
            entity.addStatus(1, 1, 1, 1, 1, "wolf", "wolf", "tier");

            strategy_SeekNearest(entity, grid, target);

            const currentVelocity = entity.getRigidbody().velocity;

            expect(oldVelocity).toEqual({ x: 0, y: 0 });
            expect(currentVelocity).toEqual({ x: 1, y: 0 });
        });
    });
});

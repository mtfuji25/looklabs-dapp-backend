import { GridUtils } from "../../../Utils/GridUtils";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { ECS } from "../Core/Ecs";
import { strategy_SeekNearest } from "./Seek";

const tests = [
    {
        path: [
            [0, 0], [1, 0], [2, 0], [2, 1], [2, 2]
        ],
        cells: { x: 5, y: 5 },
        entityCell: { x: 0, y: 0 },
        targetCell: { x: 2, y: 2 },
        expectedVelocity: { x: 1, y: 0 }
    },
    {
        path: [
          [ 36, 45 ], [ 36, 46 ], [ 36, 47 ],
          [ 36, 48 ], [ 36, 49 ], [ 36, 50 ],
          [ 36, 51 ], [ 36, 52 ], [ 36, 53 ],
          [ 36, 54 ], [ 36, 55 ], [ 36, 56 ],
          [ 36, 57 ], [ 36, 58 ], [ 36, 59 ],
          [ 36, 60 ], [ 36, 61 ], [ 36, 62 ],
          [ 36, 63 ], [ 36, 64 ], [ 36, 65 ],
          [ 36, 66 ], [ 36, 67 ], [ 36, 68 ],
          [ 36, 69 ], [ 36, 70 ], [ 36, 71 ],
          [ 36, 72 ], [ 36, 73 ], [ 36, 74 ],
          [ 36, 75 ], [ 36, 76 ], [ 36, 77 ]
        ],
        cells: { x: 100, y: 100 },
        entityCell: { x: 36, y: 45 },
        targetCell: { x: 36, y: 77 },
        expectedVelocity: { x: 0, y: -1 }
    }
];

describe("Seek", () => {
    describe("strategy_SeekNearest", () => {
        tests.forEach((t, i) => {
            test(`Test ${i}`, () => {
                // Mock functions
                GridUtils.getCellWalkable = () => 0;
                GridUtils.finder.findPath = (_, __) => t.path;

                const grid = new Grid(t.cells.x, t.cells.y);
                const ecs = new ECS();

                const entityPos = GridUtils.convertCellToPos(
                    new Vec2(t.entityCell.x, t.entityCell.y),
                    grid
                );
                const targetPos = GridUtils.convertCellToPos(
                    new Vec2(t.targetCell.x, t.targetCell.y),
                    grid
                );

                const entity = ecs.createEntity(entityPos.x, entityPos.y, "entity", 1);
                const target = ecs.createEntity(targetPos.x, targetPos.y, "target", 2);

                grid.addDynamic(entity);
                grid.addDynamic(target);

                const oldVelocity = entity.getRigidbody().velocity;

                // Needed to add speed to the entity to be able to move
                entity.addStatus(1, 1, 1, 1, 1, "wolf", "wolf", "tier");

                // Check why this is necessary
                entity.getBehavior().staticCollide = true;

                strategy_SeekNearest(entity, grid, target);

                const currentVelocity = entity.getRigidbody().velocity;

                expect(oldVelocity).toEqual({ x: 0, y: 0 });
                expect(currentVelocity).toEqual(t.expectedVelocity);
            });
        });
    });
});
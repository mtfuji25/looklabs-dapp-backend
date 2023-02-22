import { AStarFinder } from "../../../Utils/astar/astar";
import { GridUtils } from "../../../Utils/GridUtils";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { ECS, Entity } from "../Core/Ecs";
import { _getPathFinderDirection } from "./Seek";

describe("Seek", () => {
    GridUtils.getCellWalkable = () => 0;
    test("Test 1", () => {
        GridUtils.finder = new AStarFinder({
            grid: {
                matrix: [
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0]
                ]
            },
            diagonalAllowed: false,
            includeStartNode: true,
            includeEndNode: true
        });

        const ecs = new ECS();
        const entity = new Entity(ecs, [1], 1, "name", 1);
        entity.addStatus(1, 1, 1, 1, 1, "wolf", "wolf", "tier");

        const result = _getPathFinderDirection(
            entity,
            [new Vec2(0, 0)],
            new Vec2(3, 0),
            new Grid(5, 5)
        );

        expect(result).toEqual({ x: 1, y: 0 });
    });

    test("Test 2", () => {
        GridUtils.finder = new AStarFinder({
            grid: {
                matrix: [
                    [0, 0, 0, 0, 0],
                    [1, 0, 0, 0, 0],
                    [1, 0, 0, 0, 0],
                    [1, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0]
                ]
            },
            diagonalAllowed: false,
            includeStartNode: true,
            includeEndNode: true
        });

        const ecs = new ECS();
        const entity = new Entity(ecs, [1], 1, "name", 1);
        entity.addStatus(1, 1, 1, 1, 1, "wolf", "wolf", "tier");

        const result = _getPathFinderDirection(
            entity,
            [new Vec2(0, 0)],
            new Vec2(0, 4),
            new Grid(5, 5)
        );

        expect(result).toEqual({ x: 1, y: 0 });
    });

    test("Test 3", () => {
        GridUtils.finder = new AStarFinder({
            grid: {
                matrix: [
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 1],
                    [0, 0, 0, 0, 1],
                    [0, 0, 0, 0, 1],
                    [0, 0, 0, 0, 0]
                ]
            },
            diagonalAllowed: false,
            includeStartNode: true,
            includeEndNode: true
        });

        const ecs = new ECS();
        const entity = new Entity(ecs, [1], 1, "name", 1);
        entity.addStatus(1, 1, 1, 1, 1, "wolf", "wolf", "tier");

        const result = _getPathFinderDirection(
            entity,
            [new Vec2(4, 4)],
            new Vec2(4, 0),
            new Grid(5, 5)
        );

        expect(result).toEqual({ x: -1, y: 0 });
    });

    test("Test 3", () => {
        GridUtils.finder = new AStarFinder({
            grid: {
                matrix: [
                    [0, 0, 0, 0, 0],
                    [0, 1, 1, 1, 0],
                    [0, 1, 1, 1, 0],
                    [0, 1, 1, 1, 0],
                    [0, 0, 0, 0, 0]
                ]
            },
            diagonalAllowed: false,
            includeStartNode: true,
            includeEndNode: true
        });

        const ecs = new ECS();
        const entity = new Entity(ecs, [1], 1, "name", 1);
        entity.addStatus(1, 1, 1, 1, 1, "wolf", "wolf", "tier");

        const result = _getPathFinderDirection(
            entity,
            [new Vec2(4, 2)],
            new Vec2(0, 2),
            new Grid(5, 5)
        );

        expect(result).toEqual({ x: 0, y: 1 });
    });
});

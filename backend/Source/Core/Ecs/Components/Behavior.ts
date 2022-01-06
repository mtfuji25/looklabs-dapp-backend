import { Vec2 } from "../../../Utils/Math";
import { EcsSysStratFn, Entity } from "../Core/Ecs";
import { Rigidbody } from "./Rigidbody";
import { Status } from "./Status";
import { Transform } from "./Transform";

class Behavior {

    public static berserker: boolean = false;
    public static lastDeath: number = Date.now();

    public status: Status;
    public transform: Transform;
    public rigidbody: Rigidbody;
    public staticCollide: boolean = false;
    public staticNormal: Vec2[] = [];
    public staticCenter: Vec2[] = [];

    // Nearby enemies
    public inRange: Entity[] = [];
    public nearest: Entity | null;
    public inRangeByTier: Record<string, Entity[]> = {};
    public nearestByTier: Record<string, Entity> = {};

    // Attacking status
    public refresh: number = 0.0;
    public attacking: boolean = false;

    // Attacking enemies
    public target: Entity | null;
    public colliding: Entity[] = [];

    // Healing purpose
    public healing: boolean = false;

    public current:EcsSysStratFn;
    public previous:EcsSysStratFn;
    
    //wander
    public wanderVelocity:Vec2 = new Vec2();
    public wanderTimeMax:number = 80;
    public wanderTimeMin:number = 20;
    public wanderTime:number = 0;
    public wanderSteer:number = 1;
    public wanderSteerChangeTime:number = 0;
    

    constructor(
        status: Status,
        transform: Transform,
        rigidbody: Rigidbody,
    ) {
        this.status = status;
        this.transform = transform;
        this.rigidbody = rigidbody;
    }

    changeBehavior (newState:EcsSysStratFn):void {
        this.previous = this.current;
        this.current = newState;
    }
}

export { Behavior };

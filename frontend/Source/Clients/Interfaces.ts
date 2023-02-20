import { Vec2 } from "../Utils/Math";

const requests = {
    mapData: "map-data",
    gameStatus: "game-status",
    playerNames: "player-names",
    gameState: "game-state"
};

const msgTypes = {
    mapData: "map-data",
    enemy: "enemy",
    gameStatus: "game-status",
    remainPlayers: "remain-players",
    gameState: "game-state"
};

type MsgTypes = "kill" | "enemy" | "map-data" | "game-status" | "game-state"  | "remain-players" | "game-time" | "player-names";
type MsgInterfaces = KillMsg | RemainPlayersMsg | MapData | GameStatus | GameState | PlayerCommand | GameTimeMsg | PlayerNames;
type GameStateTypes = "spawn" | "countdown3" |  "countdown2" |  "countdown1" | "countdown0" | "fight"

type ListenerTypes =
    | "map-data"
    | "game-status"
    | "connection"
    | "connection-lost"
    | "kill"
    | "remain-players"
    | "enemy"
    | "game-time"
    | "game-state"
    | "response"
    | "player-names";

// Ws messages
interface MapData {
    msgType: "map-data";
    gameId: number;
    mapData: any;
}

interface GameStatus {
    msgType: "game-status";
    gameId: number;
    lastGameId: number;
    gameStatus: "lobby" | "awaiting" | "not-found" | "restarting";
}

interface GameState {
    msgType: "game-state";
    gameId: number;
    gameState: GameStateTypes
}

interface GameTimeMsg {
    msgType: "game-time",
    hours: string,
    minutes: string, 
    seconds: string
}

interface PlayerNames {
    msgType: "player-names";
    gameId: number;
    names: Record<string, string>;
}

interface PlayerCommand {
    msgType: "enemy";
    type: "create" | "update" | "delete";
    id: string;
    pos: {
        x: number;
        y: number;
    };
    action: number;
    health: number;
}

interface KillMsg {
    msgType: "kill";
    killer: string;
    action: string;
    killed: string;
}

interface RemainPlayersMsg {
    msgType: "remain-players";
    totalPlayers: number;
    remainingPlayers: number;
}

interface RequestMsg {
    uuid: string;
    type: "request";
    content: {
        type: ListenerTypes;
    } & {
        [x: string]: any;
    };
}

interface ServerMsg {
    uuid: string;
    type: "response" | "broadcast" | "send";
    content: KillMsg | PlayerCommand | RemainPlayersMsg | MapData | GameStatus | GameState | GameTimeMsg | PlayerNames;
}

// WebSocket Listeners
type OnConnectionFn = (event: Event) => boolean;
type OnConnectionLostFn = (event: Event) => boolean;
type OnKillFn = (msg: ServerMsg) => boolean;
type OnRemainPlayersFn = (msg: ServerMsg) => boolean;
type OnMapDataFn = (msg: ServerMsg) => boolean;
type OnGameStatusFn = (msg: ServerMsg) => boolean;
type OnGameStateFn = (msg: ServerMsg) => boolean;
type OnReadyFn = (msg: ServerMsg) => boolean;
type OnEnemyFn = (msg: ServerMsg) => boolean;
type OnResponseFn = (msg: ServerMsg) => boolean;
type OnGameTimeFn = (msg: ServerMsg) => boolean;

type OnListenerFns =
    | OnConnectionFn
    | OnKillFn
    | OnRemainPlayersFn
    | OnMapDataFn
    | OnGameStatusFn
    | OnConnectionLostFn
    | OnEnemyFn
    | OnResponseFn
    | OnGameTimeFn
    | OnGameStateFn
    | OnReadyFn;

type msgHandlerFn = (data: ServerMsg) => void;

// Listener types
interface Listener {
    type: ListenerTypes;
    callback: OnListenerFns;
    destroy: () => void;
    id: string;
}

interface KillListener extends Listener {
    callback: OnKillFn;
}

interface RemainPlayersListener extends Listener {
    callback: OnRemainPlayersFn;
}

interface ConnectionLostListener extends Listener {
    callback: OnConnectionLostFn;
}

interface MapDataListener extends Listener {
    callback: OnMapDataFn;
}

interface GameStatusListener extends Listener {
    callback: OnGameStatusFn;
}

interface GameStateListener extends Listener {
    callback: OnGameStateFn;
}

interface OnConnectionListener extends Listener {
    callback: OnConnectionFn;
}

interface EnemyListener extends Listener {
    callback: OnEnemyFn;
}

interface GameTimeListener extends Listener {
    callback: OnGameTimeFn;
}

interface ResponseListener extends Listener {
    callback: OnResponseFn;
}

export {
    requests,
    msgTypes,
    MapData,
    GameStatus,
    GameState,
    PlayerCommand,
    MsgTypes,
    MsgInterfaces,
    RequestMsg,
    ListenerTypes,
    KillMsg,
    RemainPlayersMsg,
    GameTimeMsg,
    Listener,
    MapDataListener,
    GameStatusListener,
    GameStateListener,
    OnConnectionListener,
    ConnectionLostListener,
    ResponseListener,
    EnemyListener,
    KillListener,
    RemainPlayersListener,
    GameTimeListener,
    OnListenerFns,
    OnEnemyFn,
    OnConnectionFn,
    PlayerNames,
    OnConnectionLostFn,
    OnGameStatusFn,
    OnGameStateFn,
    OnResponseFn,
    OnGameTimeFn,
    OnKillFn,
    OnRemainPlayersFn,
    ServerMsg,
    msgHandlerFn,
    GameStateTypes
};

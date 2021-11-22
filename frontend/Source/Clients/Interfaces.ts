import { Vec2 } from "../Utils/Math";

const requests = {
    gameStatus: "game-status"
};

const msgTypes = {
    enemy: "enemy",
    gameStatus: "game-status"
};

type MsgTypes = "kill" | "enemy" | "game-status" | "remain-players";
type MsgInterfaces = KillMsg | RemainPlayersMsg | GameStatus | PlayerCommand;

type ListenerTypes =
    | "game-status"
    | "connection"
    | "connection-lost"
    | "kill"
    | "remain-players"
    | "enemy"
    | "response";

// Ws messages
interface GameStatus {
    msgType: "game-status";
    gameId: number;
    lastGameId: number;
    gameStatus: "lobby" | "awaiting" | "not-found";
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
    attack: number;
    speed: number;
    defense: number;
    cooldown: number;
    maxHealth: number;
    survived: number;
    kills: number;
}

interface KillMsg {
    msgType: "kill";
    killer: string;
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
    content: KillMsg | PlayerCommand | RemainPlayersMsg | GameStatus;
}

// WebSocket Listeners
type OnConnectionFn = (event: Event) => boolean;
type OnConnectionLostFn = (event: Event) => boolean;
type OnKillFn = (msg: ServerMsg) => boolean;
type OnRemainPlayersFn = (msg: ServerMsg) => boolean;
type OnGameStatusFn = (msg: ServerMsg) => boolean;
type OnReadyFn = (msg: ServerMsg) => boolean;
type OnEnemyFn = (msg: ServerMsg) => boolean;
type OnResponseFn = (msg: ServerMsg) => boolean;

type OnListenerFns =
    | OnConnectionFn
    | OnKillFn
    | OnRemainPlayersFn
    | OnGameStatusFn
    | OnConnectionLostFn
    | OnEnemyFn
    | OnResponseFn
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

interface GameStatusListener extends Listener {
    callback: OnGameStatusFn;
}

interface OnConnectionListener extends Listener {
    callback: OnConnectionFn;
}

interface EnemyListener extends Listener {
    callback: OnEnemyFn;
}

interface ResponseListener extends Listener {
    callback: OnResponseFn;
}

export {
    requests,
    msgTypes,
    GameStatus,
    PlayerCommand,
    MsgTypes,
    MsgInterfaces,
    RequestMsg,
    ListenerTypes,
    KillMsg,
    RemainPlayersMsg,
    Listener,
    GameStatusListener,
    OnConnectionListener,
    ConnectionLostListener,
    ResponseListener,
    EnemyListener,
    KillListener,
    RemainPlayersListener,
    OnListenerFns,
    OnEnemyFn,
    OnConnectionFn,
    OnConnectionLostFn,
    OnGameStatusFn,
    OnResponseFn,
    OnKillFn,
    OnRemainPlayersFn,
    ServerMsg,
    msgHandlerFn
};

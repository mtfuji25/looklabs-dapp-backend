import { Vec2 } from "../Utils/Math";

const requests = {
    gameStatus: "game-status",
    playerNames: "player-names"
};

const msgTypes = {
    enemy: "enemy",
    gameStatus: "game-status",
    remainPlayers: "remain-players"
};

type MsgTypes = "kill" | "enemy" | "game-status" | "remain-players" | "game-time" | "player-names";
type MsgInterfaces = KillMsg | RemainPlayersMsg | GameStatus | PlayerCommand | GameTimeMsg | PlayerNames;

type ListenerTypes =
    | "game-status"
    | "connection"
    | "connection-lost"
    | "kill"
    | "remain-players"
    | "enemy"
    | "game-time"
    | "response"
    | "player-names";

// Ws messages
interface GameStatus {
    msgType: "game-status";
    gameId: number;
    lastGameId: number;
    gameStatus: "lobby" | "awaiting" | "not-found";
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
    attack: number;
    speed: number;
    defense: number;
    cooldown: number;
    maxHealth: number;
    survived: number;
    kills: number;
    char_class: string;
    name: string;
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
    content: KillMsg | PlayerCommand | RemainPlayersMsg | GameStatus | GameTimeMsg | PlayerNames;
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
type OnGameTimeFn = (msg: ServerMsg) => boolean;

type OnListenerFns =
    | OnConnectionFn
    | OnKillFn
    | OnRemainPlayersFn
    | OnGameStatusFn
    | OnConnectionLostFn
    | OnEnemyFn
    | OnResponseFn
    | OnGameTimeFn
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

interface GameTimeListener extends Listener {
    callback: OnGameTimeFn;
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
    GameTimeMsg,
    Listener,
    GameStatusListener,
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
    OnResponseFn,
    OnGameTimeFn,
    OnKillFn,
    OnRemainPlayersFn,
    ServerMsg,
    msgHandlerFn
};

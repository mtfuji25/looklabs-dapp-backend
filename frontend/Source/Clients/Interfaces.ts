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
type OnServerMsgFn = (msg: ServerMsg) => boolean;

type OnListenerFns =
    | OnConnectionFn
    | OnConnectionLostFn
    | OnServerMsgFn;

type msgHandlerFn = (data: ServerMsg) => void;

// Listener types
interface Listener {
    type: ListenerTypes;
    callback: OnListenerFns;
    destroy: () => void;
    id: string;
}

interface ConnectionLostListener extends Listener {
    callback: OnConnectionLostFn;
}
interface OnConnectionListener extends Listener {
    callback: OnConnectionFn;
}

interface ServerMsgListener extends Listener {
    callback: (msg: ServerMsg) => boolean;
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
    OnServerMsgFn,
    ServerMsgListener,
    OnConnectionListener,
    ConnectionLostListener,
    OnListenerFns,
    OnConnectionFn,
    PlayerNames,
    OnConnectionLostFn,
    ServerMsg,
    msgHandlerFn,
    GameStateTypes
};

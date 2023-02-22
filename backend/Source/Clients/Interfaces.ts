import { WebSocket } from "ws";

// Messages types and values

const msgTypes = {
    kill: "kill",
    enemy: "enemy",
    gameStatus: "game-status",
    remainPlayer: "remain-players",
    gameState: "game-state"
};

type MsgTypes = "kill" | "enemy" | "game-status" | "game-state" | "remain-players" | "game-time";
type MsgInterfaces = KillMsg | RemainPlayersMsg | MapData | GameStatus |  GameState | PlayerCommand | GameTimeMsg | PlayerNames;
type GameStateTypes = "spawn" | "countdown3" | "countdown2" | "countdown1" | "countdown0" | "fight"
//
//  Msgs interfaces
//

interface KillMsg {
    msgType: "kill";
    killer: string;
    killed: string;
    action: string;
}

interface GameTimeMsg {
    msgType: "game-time",
    hours: string,
    minutes: string, 
    seconds: string
}

interface RemainPlayersMsg {
    msgType: "remain-players";
    totalPlayers: number;
    remainingPlayers: number;
}

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
    gameState: GameStateTypes;
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

// Requests types and values

const requests = {
    mapData: "map-data",
    gameStatus: "game-status",
    playerNames: "player-names",
    gameState: "game-state"
};

type ListenerTypes = "map-data" | "game-status" | "connection" | "player-names" | "game-state";

// Interfaces
interface IncomingMsg {
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

interface ReplyableMsg {
    content: {
        type: ListenerTypes;
    } & {
        [x: string]: any;
    };
    reply: (msg: MsgInterfaces) => void;
}

// Listeners
// Callback types
type OnConnectionFn = (event: WebSocket) => boolean;
type OnReplyableMsgFn = (event: ReplyableMsg) => boolean;

type OnListenerFns = OnConnectionFn | OnReplyableMsgFn;

type msgHandlerFn = (data: IncomingMsg, client: WebSocket) => void;

// Listener types
interface Listener {
    type: ListenerTypes;
    callback: OnListenerFns;
    destroy: () => void;
    id: string;
}

interface ReplyableMsgListener extends Listener {
    callback: OnReplyableMsgFn;
}

interface OnConnectionListener extends Listener {
    callback: OnConnectionFn;
}


export {
    requests,
    msgTypes,
    ListenerTypes,
    MsgTypes,
    ServerMsg,
    MapData,
    GameStatus,
    GameState,
    PlayerNames,
    GameTimeMsg,
    PlayerCommand,
    IncomingMsg,
    ReplyableMsg,
    Listener,
    ReplyableMsgListener,
    OnConnectionListener,
    OnListenerFns,
    OnReplyableMsgFn,
    OnConnectionFn,
    msgHandlerFn,
    MsgInterfaces,
    GameStateTypes
};

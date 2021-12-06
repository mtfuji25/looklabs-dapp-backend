import { WebSocket } from "ws";

// Messages types and values

const msgTypes = {
    kill: "kill",
    enemy: "enemy",
    gameStatus: "game-status",
    remainPlayer: "remain-players"
};

type MsgTypes = "kill" | "enemy" | "game-status" | "remain-players" | "game-time";
type MsgInterfaces = KillMsg | RemainPlayersMsg | GameStatus | PlayerCommand | GameTimeMsg;

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
    hours: number,
    minutes: number, 
    seconds: number
}

interface RemainPlayersMsg {
    msgType: "remain-players";
    totalPlayers: number;
    remainingPlayers: number;
}

interface GameStatus {
    msgType: "game-status";
    gameId: number;
    lastGameId: number;
    gameStatus: "lobby" | "awaiting" | "not-found";
}

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
    char_class: string;
    name: string;
}

// Requests types and values

const requests = {
    gameStatus: "game-status"
};

type ListenerTypes = "game-status" | "connection";

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
    content: KillMsg | PlayerCommand | RemainPlayersMsg | GameStatus | GameTimeMsg;
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
type OnGameStatusFn = (event: ReplyableMsg) => boolean;

type OnListenerFns = OnConnectionFn | OnGameStatusFn;

type msgHandlerFn = (data: IncomingMsg, client: WebSocket) => void;

// Listener types
interface Listener {
    type: ListenerTypes;
    callback: OnListenerFns;
    destroy: () => void;
    id: string;
}

interface GameStatusListener extends Listener {
    callback: OnGameStatusFn;
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
    GameStatus,
    GameTimeMsg,
    PlayerCommand,
    IncomingMsg,
    ReplyableMsg,
    Listener,
    GameStatusListener,
    OnConnectionListener,
    OnListenerFns,
    OnGameStatusFn,
    OnConnectionFn,
    msgHandlerFn,
    MsgInterfaces
};

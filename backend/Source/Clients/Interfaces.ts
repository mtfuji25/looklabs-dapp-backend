import { WebSocket } from "ws";

// Messages types and values

const msgTypes = {
    kill: "kill",
    enemy: "enemy",
    gameStatus: "game-status",
    remainPlayer: "remain-players"
};

type MsgTypes = "kill" | "enemy" | "game-status" | "remain-players" | "game-time";
type MsgInterfaces = KillMsg | RemainPlayersMsg | GameStatus | PlayerCommand | GameTimeMsg | PlayerNames;

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

// Requests types and values

const requests = {
    gameStatus: "game-status",
    playerNames: "player-names"
};

type ListenerTypes = "game-status" | "connection" | "player-names";

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
    content: KillMsg | PlayerCommand | RemainPlayersMsg | GameStatus | GameTimeMsg | PlayerNames;
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
type OnPlayerNamesFn = (event: ReplyableMsg) => boolean;

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

interface PlayerNamesListener extends Listener {
    callback: OnPlayerNamesFn;
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
    PlayerNames,
    GameTimeMsg,
    PlayerCommand,
    IncomingMsg,
    ReplyableMsg,
    Listener,
    GameStatusListener,
    PlayerNamesListener,
    OnPlayerNamesFn,
    OnConnectionListener,
    OnListenerFns,
    OnGameStatusFn,
    OnConnectionFn,
    msgHandlerFn,
    MsgInterfaces
};

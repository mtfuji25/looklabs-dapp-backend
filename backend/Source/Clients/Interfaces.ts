import { Vec2 } from "../Utils/Math";

// Messages types and values

const msgTypes = {
    kill: "kill",
    enemy: "enemy",
    gameStatus: "game-status",
    remainPlayer: "remain-players"
};

type MsgTypes = "kill" | "enemy" | "game-status" | "remain-players";

//
//  Msgs interfaces
//

interface KillMsg {
    msgType: "kill";
    killer: string;
    killed: string;
}

interface RemainPlayersMsg {
    msgType: "remain-players";
    totalPlayers: number;
    remainingPlayers: number;
    // tudo que tuy precisa
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
}

// Requests types and values

const requests = {
    gameStatus: "game-status"
};

type Listeners = "game-status" | "connection";

// Interfaces
interface IncommingMsg {
    uuid: string;
    type: "request";
    content: {
        type: Listeners;
    } & {
        [x: string]: any;
    };
}

interface ServerMsg {
    uuid: string;
    type: "response" | "broadcast" | "send";
    content: KillMsg | PlayerCommand | RemainPlayersMsg | GameStatus;
}

export { requests, msgTypes, Listeners, MsgTypes, ServerMsg, GameStatus, PlayerCommand, IncommingMsg };

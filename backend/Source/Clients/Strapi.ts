import axios, { AxiosInstance, AxiosResponse, AxiosError } from "axios";
import express, { Express } from "express";

interface ScheduledGame {
    id: number;
    game_date: string;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
    scheduled_game_participants: ScheduledGameParticipant[];
}

interface ScheduledGameParticipant {
    id: number;
    nft_id: string;
    user_address: string;
    scheduled_game: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

interface GameParticipantsResult {
    scheduled_game_participant: number;
    result: "died" | "won";
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

type OnMsgFn = (message: ScheduledGame) => boolean;
type OnHookFn = (message: ScheduledGame) => void;

class StrapiClient {
    
    private msgListeners: OnMsgFn[] = [];
    private hookListeners: OnHookFn[] = [];

    private readonly api: AxiosInstance;
    private readonly expressApp: Express = express();
    // any type because ts complains if I use http.server, the correct type
    private expressServer: any;

    constructor(host: string, port: number, expressHost: string, expressPort: number) {
        // start axios instance
        this.api = axios.create({
            baseURL: "https://thepit-strapi-3fiy6wgliq-nw.a.run.app/",
        })

        // start express server
        this.startExpressServer(expressPort);
    }

    private async get(url: string): Promise<AxiosResponse> {
        return this.api.get(url);
    }

    private async post(url: string, data: any): Promise<AxiosResponse>  {
        return this.api.post(url, data);
    }

    private async put(url: string): Promise<AxiosResponse>  {
        return this.api.put(url);
    }

    // starts express server
    private startExpressServer(expressPort: number): void {
        // route for the webhook that sends when a game is scheduled
        this.expressApp.post("/scheduled-games", (req, res) => {
            this.getNearestGame().then((data) => {
                // data represents the nearest game
                for (let listener of this.msgListeners) {
                    if (listener(data))
                        break;
                }

                for (let hook of this.hookListeners) {
                    hook(data);
                }

                this.hookListeners = [];
            })

            res.sendStatus(200);
        });

        // listen on port x
        this.expressServer = this.expressApp.listen(expressPort, () => {
            console.log("Express listening on port: ", expressPort)
        });
    }
    

    // Creates a result for a participant on strapi. Takes a player and it's result enum(string)
    // async because consistency is not needed immediately
    async createParticipantResult(result: GameParticipantsResult): Promise<AxiosResponse> {
        return this.post("game-participants-results", result);
    }

    // gets the nearest game
    async getNearestGame(): Promise<ScheduledGame>{
        // get current time
        const now = new Date().toISOString();

        // queries scheduled games, where the game happens after current time, and sorts by
        // ascending, so it returns the nearest game;
        return (await this.get(`scheduled-games?game_date_gte=${now}&_sort=game_date:ASC&_limit=1`)).data[0];
    }

    // get chosen game
    async getGameById(id: number): Promise<ScheduledGame> {
        return (await this.get(`scheduled-games/${id}`)).data;
    }

    // Default engine start call
    start(): void {}

    // Default engine close call
    // closes express server
    close(): void {
        console.log("Closing express server.")
        this.expressServer.close();
    }

    onWebhook(fn: OnHookFn) {
        this.hookListeners.push(fn);
    }

    addMsgListener(fn: OnMsgFn): number {
        this.msgListeners.push(fn);
        return this.msgListeners.length - 1;
    }

    remMsgListener(id: number) {
        this.msgListeners.splice(id, 1);
    }
}

export { StrapiClient, ScheduledGame, ScheduledGameParticipant, GameParticipantsResult };

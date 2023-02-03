import axios, { AxiosInstance, AxiosResponse } from "axios";
import { Logger } from "../Utils/Logger";

export interface ScheduledGame {
    id: number;
    game_date: string;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
    max_participants?: number;
    scheduled_game_participants: ScheduledGameParticipant[];
}

export interface ScheduledGameParticipant {
    id: number;
    nft_id: string;
    name: string;
    user_address: string;
    scheduled_game: number;
    image_address: string;
    game_participants_result: GameParticipantsResult;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

export interface GameParticipantsResult {
    scheduled_game_participant: number;
    survived_for: number;
    kills: number;
    health: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

// Return value for rest api
export interface ParticipantDetails {
    name: string;
    description: string;
    image: string;
    dna: string;
    edition: number;
    date: number;
    spritesheet: string;
    attributes: DetailAttribute[];
}

// Attributes of a detail
export interface DetailAttribute {
    trait_type: string;
    value: number | string;
}

// Parent class, should not be used directly. Use Strapi or MockedApi instead
export class GameApi {
    protected host: string;
    protected authToken: string;
    public readonly serverRoot: string = "https://token.thepitnft.com/";
    protected readonly api: AxiosInstance;

    // restApi for player attributes
    protected readonly restApi: AxiosInstance;

    // any type because ts complains if I use http.server, the correct type
    protected expressServer: any;

    constructor(host: string, token: string) {
        this.host = host;
        this.authToken = token;
        // start axios instance
        this.api = axios.create({
            baseURL: `${this.host}`,
            headers: { Authorization: `bearer ${this.authToken}` }
        });

        // start axios for restApi
        this.restApi = axios.create({
            baseURL: this.serverRoot
        });
    }

    protected async get(url: string): Promise<AxiosResponse> {
        return this.api.get(url);
    }

    protected async post(url: string, data: any): Promise<AxiosResponse> {
        return this.api.post(url, data);
    }

    protected async put(url: string): Promise<AxiosResponse> {
        return this.api.put(url);
    }

    // Creates a result for a participant on strapi. Takes a player and it's result enum(string)
    // async because consistency is not needed immediately
    async createParticipantResult(result: GameParticipantsResult): Promise<AxiosResponse> {
        return null as any;
    }

    // gets the nearest game
    async getNearestGame(): Promise<ScheduledGame> {
        return null as ScheduledGame;
    }

    // get chosen game
    async getGameById(id: number): Promise<ScheduledGame> {
        return null as ScheduledGame;
    }

    async getGameParticipants(id: number) {
        return null as ScheduledGameParticipant[];
    }

    // get the details for a chosen participant
    async getParticipantDetails(
        tokenAddress: string,
        tokenId: number
    ): Promise<ParticipantDetails> {
        return null as ParticipantDetails;
    }

    // Default engine start call
    start(): void {}

    // Default engine close call
    // closes express server
    close(): void {
        Logger.info("Closing express server.");
        this.expressServer.close();
    }
}
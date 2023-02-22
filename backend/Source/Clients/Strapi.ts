import axios, { AxiosInstance, AxiosResponse, AxiosError } from "axios";

interface ScheduledGame {
    id: number;
    game_date: string;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
    max_participants?: number;
    scheduled_game_participants: ScheduledGameParticipant[];
}

interface ScheduledGameParticipant {
    id: number;
    nft_id: string;
    user_address: string;
    name: string;
    scheduled_game: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

interface GameParticipantsResult {
    scheduled_game_participant: number;
    survived_for: number;
    kills: number;
    health: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

// Return value for rest api
interface ParticipantDetails {
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
interface DetailAttribute {
    trait_type: string;
    value: number | string;
}

class StrapiClient {
    protected host: string;

    // strapiApi
    protected readonly api: AxiosInstance;

    // restApi for player attributes
    protected readonly restApi: AxiosInstance;
    protected readonly authToken: string;

    constructor(host: string, token: string) {
        this.host = host;
        this.authToken = token;
        // start axios instance
        this.api = axios.create({
            baseURL: host
        });

        // start axios for restApi
        this.restApi = axios.create({
            baseURL: "https://token.thepitnft.com/"
        });
    }

    protected async get(url: string): Promise<AxiosResponse> {
        return this.api.get(url, { headers: { Authorization: `bearer ${this.authToken}` } });
    }

    protected async post(url: string, data: any): Promise<AxiosResponse> {
        return this.api.post(url, data, { headers: { Authorization: `bearer ${this.authToken}` } });
    }

    // Creates a result for a participant on strapi. Takes a player and it's result enum(string)
    // async because consistency is not needed immediately
    async createParticipantResult(result: GameParticipantsResult): Promise<AxiosResponse> {
        return this.post("game-participants-results", {
            data: result
        });
    }

    // gets the nearest game
    async getNearestGame(): Promise<ScheduledGame> {
        // get current time
        const now = new Date().toISOString();

        // queries scheduled games, where the game happens after current time, and sorts by
        // ascending, so it returns the nearest game;
        // const response = (await this.get(`scheduled-games?game_date_gte=${now}&_sort=game_date:ASC&_limit=1`)).data["data"][0];
        const response_arr = (
            await this.get(
                `scheduled-games?filters[game_date][$gte]=${now}&sort=game_date:asc&populate=*`
            )
        ).data["data"];
        if (response_arr.length != 0) {
            const response = response_arr[0];
            const attributes = response.attributes;
            return {
                id: response.id,
                published_at: attributes.publishedAt,
                created_at: attributes.createdAt,
                updated_at: attributes.updatedAt,
                game_date: attributes.game_date,
                max_participants: attributes.max_participants,
                scheduled_game_participants: attributes.scheduled_game_participants.data.map(
                    (participant: any) => {
                        const attributes = participant.attributes;
                        return {
                            id: participant.id,
                            nft_id: attributes.nft_id,
                            user_address: attributes.user_address,
                            name: attributes.name,
                            scheduled_game: response.id,
                            published_at: attributes.publishedAt,
                            created_at: attributes.createdAt,
                            updated_at: attributes.updatedAt
                        };
                    }
                )
            };
        } else return null;
    }

    // get chosen game
    async getGameById(id: number): Promise<ScheduledGame> {
        const response = (await this.get(`scheduled-games/${id}?populate=*`)).data["data"];
        const attributes = response.attributes;
        return {
            id: response.id,
            game_date: attributes.game_date,
            max_participants: attributes.max_participants,
            scheduled_game_participants: attributes.scheduled_game_participants.data.map(
                (participant: any) => {
                    const attributes = participant.attributes;
                    return {
                        id: participant.id,
                        nft_id: attributes.nft_id,
                        user_address: attributes.user_address,
                        name: attributes.name,
                        scheduled_game: response.id,
                        published_at: attributes.publishedAt,
                        created_at: attributes.createdAt,
                        updated_at: attributes.updatedAt   
                    };
                }
            )
        };
    }

    // get the details for a chosen participant
    async getParticipantDetails(tokenAddr: string, tokenId: string): Promise<ParticipantDetails> {
        return (await this.restApi.get(`${tokenAddr}/${tokenId}`)).data;
    }

    // Default engine start call
    start(): void {}

    // Default engine close call
    close(): void {}
}

export {
    StrapiClient,
    ScheduledGame,
    ScheduledGameParticipant,
    GameParticipantsResult,
    ParticipantDetails,
    DetailAttribute
};

import axios, { AxiosResponse } from "axios";
import { GameApi, GameParticipantsResult, ParticipantDetails, ScheduledGame } from "./GameApi";

export class StrapiClient extends GameApi{

    // Creates a result for a participant on strapi. Takes a player and it's result enum(string)
    // async because consistency is not needed immediately
    async createParticipantResult(result: GameParticipantsResult): Promise<AxiosResponse> {
        return this.post("game-participants-results", result);
    }

    // gets the nearest game
    async getNearestGame(): Promise<ScheduledGame> {
        // get current time
        const now = new Date().toISOString();

        // queries scheduled games, where the game happens after current time, and sorts by
        // ascending, so it returns the nearest game;
        // const response = (await this.get(`scheduled-games?game_date_gte=${now}&_sort=game_date:ASC&_limit=1`)).data["data"][0];
        const response = (
            await this.get(
                `scheduled-games?filters[game_date][$gte]=${now}&sort=game_date:asc&populate=*`
            )
        ).data["data"][0];
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
                        updated_at: attributes.updatedAt,
                    };
                }
            )
        };
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

    async getGameParticipants(id: number) {

        const data = (
            await this.get(
                `scheduled-game-participants?filters[scheduled_game][id][$eq]=${id}&sort=game_participants_result.survived_for:desc&populate=*&pagination[page]=1&pagination[pageSize]=100`
            )
        ).data["data"];

        const returnValue = data.map((response: any) => {
            const attributes = response.attributes;
            return {
                id: response.id,
                nft_id: attributes.nft_id,
                name: attributes.name,
                user_address: attributes.user_address,
                scheduled_game: attributes.scheduled_game.data.id,
                image_address: attributes.image_address,
                ...(attributes.game_participants_result.data != null
                    ? {
                          game_participants_result: {
                              id: attributes.game_participants_result.data.id,
                              scheduled_game_participant: response.id,
                              ...attributes.game_participants_result.data.attributes
                          }
                      }
                    : {})
            };
        });

        return returnValue;
    }

    // get the details for a chosen participant
    async getParticipantDetails(
        tokenAddress: string,
        tokenId: number
    ): Promise<ParticipantDetails> {
        return (await this.restApi.get(`${tokenAddress}/${tokenId}`)).data;
    }
}

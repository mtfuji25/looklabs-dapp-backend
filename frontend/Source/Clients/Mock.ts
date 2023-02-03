import { ParticipantDetails, ScheduledGame } from "./Strapi";

export function mockGame(): ScheduledGame {
    return {
        id: 1,
        game_date: new Date().toISOString(),
        published_at: new Date().toISOString(),
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
        scheduled_game_participants: [
            {
                id: 1,
                nft_id: "0x03dE5D4eA3c9a899F09C56dDD3b1FCAb68af9FED",
                name: "1",
                user_address: "0xb960d6b39023cec0e9c22bcf43e46705b5ddb572",
                scheduled_game: 1,
                image_address: "",
                game_participants_result: {
                    scheduled_game_participant: 1,
                    survived_for: 1,
                    kills: 1,
                    health: 1
                }
            }
        ]
    };
}

export function mockParticipantDetails(): ParticipantDetails {
    return {
        name: "1",
        description: "1",
        image: "",
        dna: "1",
        edition: 1,
        date: 1,
        spritesheet: "1",
        attributes: [
            {
                trait_type: "a",
                value: 1
            }
        ]
    };
}

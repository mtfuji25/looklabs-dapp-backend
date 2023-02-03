import { ParticipantDetails, ScheduledGame } from "./Strapi";

export function mockGame(): ScheduledGame {
    const gameDate = new Date();
    gameDate.setSeconds(gameDate.getSeconds() + 15);

    return {
        id: 1,
        game_date: gameDate.toISOString(),
        scheduled_game_participants: [
            {
                id: 1,
                nft_id: "0x03dE5D4eA3c9a899F09C56dDD3b1FCAb68af9FED/1",
                user_address: "1",
                name: "1",
                scheduled_game: 1
            },
            {
                id: 2,
                nft_id: "0x03dE5D4eA3c9a899F09C56dDD3b1FCAb68af9FED/2",
                user_address: "2",
                name: "2",
                scheduled_game: 1
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
        spritesheet: "delta_sheep.png",
        attributes: [
            {
                trait_type: "Speed",
                value: 2
            },
            {
                trait_type: "Attack",
                value: 2
            },
            {
                trait_type: "Defence",
                value: 1
            },
            {
                trait_type: "Creature",
                value: "sheep"
            },
            {
                trait_type: "Tier",
                value: "beta"
            }
        ]
    };
}

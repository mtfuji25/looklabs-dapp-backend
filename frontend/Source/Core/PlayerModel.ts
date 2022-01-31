import { DetailAttribute, ParticipantDetails, ScheduledGameParticipant, StrapiClient } from "../Clients/Strapi";

class ParticipantDetailsModel {
    
    
    public participants:Record<string, ParticipantDetails> = {};
    private strapi:StrapiClient;

    constructor (strapi:StrapiClient) {
        this.strapi = strapi;
    }

    reset () {
        this.participants = {};
    }

    async loadPlayerDetails (players:ScheduledGameParticipant[]) {
        await Promise.all(
            players.map( async p => {
                if (!this.getDetailsForPlayer(p.nft_id)) {
                    const tokenId = Number((p.nft_id).split('/')[1]);
                    const tokenAddr = (p.nft_id).split('/')[0];
                    const details = await this.strapi.getParticipantDetails(tokenAddr, tokenId);
                    this.addDetailsForPlayer(p.nft_id, details);                    
                }
            })
        );
    }

    getDetailsForPlayer (id:string):ParticipantDetails | null {
        if (this.participants[id]) return this.participants[id];
        return null;
    }

    addDetailsForPlayer (id:string, details:ParticipantDetails) {
        this.participants[id] = details;
    }

    getTierFromAttributes (attributes:DetailAttribute[]):string  {
        const a = this.getAttributeValue(attributes, "Tier");
        if (a == null) return "beta";
        return a.toString().toLowerCase();
    }

    getAttributeValue(attributes:DetailAttribute[], key:string):string | number | null {
        const attribute = attributes.filter ( a => a.trait_type === key);
        if (attribute.length > 0)
            return attributes.filter ( a => a.trait_type === key)[0].value;
        return null;
    }

    destroy () {
        this.participants = {};
    }
}

export { ParticipantDetailsModel }
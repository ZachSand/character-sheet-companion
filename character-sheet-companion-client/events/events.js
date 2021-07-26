export const SOCKET_EVENTS = {
    FOUNDRY: {
        JOIN_ROOM: "foundry:join",
        SEND_USERS: "foundry:sendUsers",
        SEND_USER_ACTORS: "foundry:sendUserActors",
        SEND_ACTOR_DATA: "foundry:sendActorData",
        SEND_ABILITY_ROLL: "foundry:sendAbilityRoll",
        SEND_SKILL_ROLL: "foundry:sendSkillRoll",
        SEND_ITEM_ATTACK_ROLL: "foundry:sendItemAttackRoll",
        SEND_ITEM_DAMAGE_ROLL: "foundry:sendItemDamageRoll",
        SEND_WORLD_DATA: "foundry:sendWorldData",
    },
    SERVER: {
        REQUEST_FOUNDRY_USERS: "server:requestFoundryUsers",
        REQUEST_FOUNDRY_USER_ACTORS: "server:requestFoundryUserActors",
        REQUEST_FOUNDRY_ACTOR_DATA: "server:requestFoundryActorData",
        REQUEST_FOUNDRY_ABILITY_ROLL: "server:requestFoundryAbilityRoll",
        REQUEST_FOUNDRY_SKILL_ROLL: "server:requestFoundrySkillRoll",
        REQUEST_FOUNDRY_ITEM_ATTACK_ROLL: "server:requestFoundryItemAttackRoll",
        REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL: "server:requestFoundryItemDamageRoll",
        REQUEST_FOUNDRY_DISPLAY_ITEM: "server:requestFoundryDisplayItem",
        REQUEST_FOUNDRY_WORLD_DATA: "server:requestFoundryWorldData",
    },
    ERROR: {
        JOIN_ROOM: "error:join-room",
    },
};

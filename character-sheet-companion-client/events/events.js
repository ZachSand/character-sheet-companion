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
    SEND_ITEM_CONSUME_ROLL: "foundry:sendItemConsumeRoll",
    SEND_ITEM_TOOL_ROLL: "foundry:sendItemToolRoll",
    SEND_INITIATIVE_ROLL: "foundry:sendInitiativeRoll",
    SEND_SPELL_DIALOG: "foundry:sendSpellDialog",
    SEND_CHAT_DATA: "foundry:sendChatData",
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
    REQUEST_FOUNDRY_ITEM_CONSUME_ROLL: "server:requestFoundryItemConsumeRoll",
    REQUEST_FOUNDRY_ITEM_TOOL_ROLL: "server:requestFoundryItemToolRoll",
    REQUEST_FOUNDRY_INITIATIVE_ROLL: "server:requestFoundryInitiativeRoll",
    REQUEST_FOUNDRY_DISPLAY_ITEM: "server:requestFoundryDisplayItem",
    REQUEST_FOUNDRY_CHAT_DATA: "server:requestFoundryChatData",
    REQUEST_FOUNDRY_SPELL_DIALOG: "server:requestFoundrySpellDialog",
    REQUEST_FOUNDRY_WORLD_DATA: "server:requestFoundryWorldData",
    SEND_IOS_CHAT_MESSAGE: "server:sendIosChatMessage",
  },
  ERROR: {
    JOIN_ROOM: "error:join-room",
  },
};

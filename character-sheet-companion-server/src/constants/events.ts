export const SOCKET_EVENTS = {
  FOUNDRY: {
    JOIN_ROOM: "foundry:join",
    JOINED_ROOM: "foundry:joinedRoom",
    SEND_USERS: "foundry:sendUsers",
    SEND_USER_ACTORS: "foundry:sendUserActors",
    SEND_ACTOR_DATA: "foundry:sendActorData",
    SEND_ABILITY_ROLL: "foundry:sendAbilityRoll",
    SEND_SKILL_ROLL: "foundry:sendSkillRoll",
    SEND_ITEM_ATTACK_ROLL: "foundry:sendItemAttackRoll",
    SEND_ITEM_DAMAGE_ROLL: "foundry:sendItemDamageRoll",
    SEND_WORLD_DATA: "foundry:sendWorldData",
  },
  IOS: {
    JOIN_ROOM: "ios:join",
    JOINED_ROOM: "ios:joinedRoom",
    REQUEST_FOUNDRY_USERS: "ios:requestFoundryUsers",
    REQUEST_FOUNDRY_USER_ACTORS: "ios:requestFoundryUserActor",
    REQUEST_FOUNDRY_ACTOR_DATA: "ios:requestFoundryActorData",
    REQUEST_FOUNDRY_ABILITY_ROLL: "ios:requestFoundryAbilityRoll",
    REQUEST_FOUNDRY_SKILL_ROLL: "ios:requestFoundrySkillRoll",
    REQUEST_FOUNDRY_ITEM_ATTACK_ROLL: "ios:requestFoundryItemAttackRoll",
    REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL: "ios:requestFoundryItemDamageRoll",
    REQUEST_FOUNDRY_DISPLAY_ITEM: "ios:requestFoundryDisplayItem",
    REQUEST_FOUNDRY_WORLD_DATA: "ios:requestFoundryWorldData",
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
    SEND_FOUNDRY_USERS: "server:sendFoundryUsers",
    SEND_FOUNDRY_USER_ACTORS: "server:sendFoundryUserActor",
    SEND_FOUNDRY_ACTOR_DATA: "server:sendFoundryActorData",
    SEND_FOUNDRY_ABILITY_ROLL: "server:sendFoundryAbilityRoll",
    SEND_FOUNDRY_SKILL_ROLL: "server:sendFoundrySkillRoll",
    SEND_FOUNDRY_ITEM_ATTACK_ROLL: "server:sendFoundryItemAttackRoll",
    SEND_FOUNDRY_ITEM_DAMAGE_ROLL: "server:sendFoundryItemDamageRoll",
    SEND_FOUNDRY_DISPLAY_ITEM: "server:sendFoundryDisplayItem",
    SEND_FOUNDRY_WORLD_DATA: "server:sendFoundryWorldData",
  },
  ERROR: {
    GENERAL_ERROR: "error",
    JOIN_ROOM: "error:join-room",
  },
  GENERAL: {
    DISCONNECT: "disconnect",
  },
};

export const VALID_EVENTS = new Set(
  Object.values(SOCKET_EVENTS.FOUNDRY).concat(
    Object.values(SOCKET_EVENTS.IOS),
    Object.values(SOCKET_EVENTS.SERVER),
    Object.values(SOCKET_EVENTS.ERROR),
    Object.values(SOCKET_EVENTS.GENERAL)
  )
);

const foundryEventPrefix = "foundry:";
const serverEventPrefix = "server:";
const iosEventPrefix = "ios:";

const requestFoundryEventPrefix = "requestFoundry";
const sendFoundryEventPrefix = "sendFoundry";

const requestActorEventPrefix = "requestActor";
const sendActorPrefix = "sendActor";

export const SOCKET_EVENTS = {
  FOUNDRY: {
    SETUP: {
      JOIN_ROOM: foundryEventPrefix + "joinRoom",
      SEND_USERS: foundryEventPrefix + "sendUsers",
      SEND_ACTORS: foundryEventPrefix + "sendActors",
      SEND_WORLD_DATA: foundryEventPrefix + "sendWorldData",
      USER_AUTH: foundryEventPrefix + "UserAuthentication",
    },
    ACTOR: {
      SEND_ACTOR_ATTRIBUTES:
        foundryEventPrefix + sendActorPrefix + "Attributes",
      SEND_ACTOR_ABILITIES: foundryEventPrefix + sendActorPrefix + "Abilities",
      SEND_ACTOR_SKILLS: foundryEventPrefix + sendActorPrefix + "Skills",
      SEND_ACTOR_SPELL_SLOTS:
        foundryEventPrefix + sendActorPrefix + "SpellSlots",
      SEND_ACTOR_INVENTORY: foundryEventPrefix + sendActorPrefix + "Inventory",
      SEND_ACTOR_DETAILS: foundryEventPrefix + sendActorPrefix + "Details",
      SEND_ACTOR_CURRENCY: foundryEventPrefix + sendActorPrefix + "Currency",
      SEND_ACTOR_SPELLS: foundryEventPrefix + sendActorPrefix + "Spells",
      SEND_ACTOR_BASE_DATA: foundryEventPrefix + sendActorPrefix + "BaseData",
      SEND_ACTOR_CLASSES: foundryEventPrefix + sendActorPrefix + "Classes",
      SEND_ACTOR_TRAITS: foundryEventPrefix + sendActorPrefix + "Traits",
    },
    ROLL: {
      SEND_ABILITY_ROLL: foundryEventPrefix + "sendAbilityRoll",
      SEND_SKILL_ROLL: foundryEventPrefix + "sendSkillRoll",
      SEND_ITEM_ATTACK_ROLL: foundryEventPrefix + "sendItemAttackRoll",
      SEND_ITEM_DAMAGE_ROLL: foundryEventPrefix + "sendItemDamageRoll",
      SEND_ITEM_CONSUME_ROLL: foundryEventPrefix + "sendItemConsumeRoll",
      SEND_ITEM_TOOL_ROLL: foundryEventPrefix + "sendItemToolRoll",
      SEND_INITIATIVE_ROLL: foundryEventPrefix + "sendInitiativeRoll",
      SEND_DEATH_SAVE_ROLL: foundryEventPrefix + "sendDeathSaveRoll",
      SEND_HIT_DIE_ROLL: foundryEventPrefix + "sendHitDieRoll",
    },
    DISPLAY: {
      SEND_CHAT_DATA: foundryEventPrefix + "sendChatData",
    },
  },
  IOS: {
    SETUP: {
      JOIN_ROOM: iosEventPrefix + "joinRoom",
      REQUEST_FOUNDRY_USERS:
        iosEventPrefix + requestFoundryEventPrefix + "Users",
      REQUEST_FOUNDRY_WORLD_DATA:
        iosEventPrefix + requestFoundryEventPrefix + "WorldData",
      REQUEST_FOUNDRY_USER_AUTH:
        iosEventPrefix + requestFoundryEventPrefix + "UserAuthentication",
      SEND_IOS_SETUP_COMPLETE: iosEventPrefix + "sendSetupComplete",
    },
    ACTOR: {
      REQUEST_ACTOR_ATTRIBUTES:
        iosEventPrefix + requestActorEventPrefix + "Attributes",
      REQUEST_ACTOR_ABILITIES:
        iosEventPrefix + requestActorEventPrefix + "Abilities",
      REQUEST_ACTOR_SKILLS: iosEventPrefix + requestActorEventPrefix + "Skills",
      REQUEST_ACTOR_SPELL_SLOTS:
        iosEventPrefix + requestActorEventPrefix + "SpellSlots",
      REQUEST_ACTOR_INVENTORY:
        iosEventPrefix + requestActorEventPrefix + "Inventory",
      REQUEST_ACTOR_DETAILS:
        iosEventPrefix + requestActorEventPrefix + "Details",
      REQUEST_ACTOR_CURRENCY:
        iosEventPrefix + requestActorEventPrefix + "Currency",
      REQUEST_ACTOR_SPELLS: iosEventPrefix + requestActorEventPrefix + "Spells",
      REQUEST_ACTOR_BASE_DATA:
        iosEventPrefix + requestActorEventPrefix + "BaseData",
      REQUEST_ACTOR_CLASSES:
        iosEventPrefix + requestActorEventPrefix + "Classes",
      REQUEST_ACTOR_TRAITS: iosEventPrefix + requestActorEventPrefix + "Traits",
      REQUEST_ACTOR_HEALTH_CHANGE:
        iosEventPrefix + requestActorEventPrefix + "HealthChange",
      REQUEST_ACTOR_LONG_REST:
        iosEventPrefix + requestActorEventPrefix + "LongRest",
      REQUEST_ACTOR_SHORT_REST:
        iosEventPrefix + requestActorEventPrefix + "ShortRest",
    },
    ROLL: {
      REQUEST_FOUNDRY_ABILITY_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "AbilityRoll",
      REQUEST_FOUNDRY_SKILL_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "SkillRoll",
      REQUEST_FOUNDRY_ITEM_ATTACK_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "ItemAttackRoll",
      REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "ItemDamageRoll",
      REQUEST_FOUNDRY_ITEM_CONSUME_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "ItemConsumeRoll",
      REQUEST_FOUNDRY_ITEM_TOOL_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "ItemToolRoll",
      REQUEST_FOUNDRY_INITIATIVE_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "InitiativeRoll",
      REQUEST_FOUNDRY_DEATH_SAVE_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "DeathSaveRoll",
      REQUEST_FOUNDRY_HIT_DIE_ROLL:
        iosEventPrefix + requestFoundryEventPrefix + "HitDieRoll",
    },
    DISPLAY: {
      REQUEST_FOUNDRY_DISPLAY_ITEM:
        iosEventPrefix + requestFoundryEventPrefix + "DisplayItem",
      REQUEST_FOUNDRY_CHAT_DATA:
        iosEventPrefix + requestFoundryEventPrefix + "ChatData",
      SEND_FOUNDRY_CHAT_MESSAGE:
        iosEventPrefix + sendFoundryEventPrefix + "ChatMessage",
    },
  },
  SERVER: {
    SETUP: {
      REQUEST: {
        REQUEST_FOUNDRY_USERS:
          serverEventPrefix + requestFoundryEventPrefix + "Users",
        REQUEST_FOUNDRY_WORLD_DATA:
          serverEventPrefix + requestFoundryEventPrefix + "WorldData",
        REQUEST_FOUNDRY_USER_AUTH:
          serverEventPrefix + requestFoundryEventPrefix + "UserAuthentication",
      },
      SEND: {
        SEND_FOUNDRY_USERS:
          serverEventPrefix + sendFoundryEventPrefix + "Users",
        SEND_FOUNDRY_WORLD_DATA:
          serverEventPrefix + sendFoundryEventPrefix + "WorldData",
        SEND_IOS_JOINED_ROOM: serverEventPrefix + "sendIosJoinedRoom",
        SEND_FOUNDRY_JOINED_ROOM:
          serverEventPrefix + sendFoundryEventPrefix + "JoinedRoom",
        SEND_IOS_SETUP_COMPLETE:
          serverEventPrefix + sendFoundryEventPrefix + "iosSetupComplete",
        SEND_USER_AUTH:
          serverEventPrefix + sendFoundryEventPrefix + "UserAuthentication",
      },
    },
    ACTOR: {
      REQUEST: {
        REQUEST_ACTOR_ATTRIBUTES:
          serverEventPrefix + requestActorEventPrefix + "Attributes",
        REQUEST_ACTOR_ABILITIES:
          serverEventPrefix + requestActorEventPrefix + "Abilities",
        REQUEST_ACTOR_SKILLS:
          serverEventPrefix + requestActorEventPrefix + "Skills",
        REQUEST_ACTOR_SPELL_SLOTS:
          serverEventPrefix + requestActorEventPrefix + "SpellSlots",
        REQUEST_ACTOR_INVENTORY:
          serverEventPrefix + requestActorEventPrefix + "Inventory",
        REQUEST_ACTOR_DETAILS:
          serverEventPrefix + requestActorEventPrefix + "Details",
        REQUEST_ACTOR_CURRENCY:
          serverEventPrefix + requestActorEventPrefix + "Currency",
        REQUEST_ACTOR_SPELLS:
          serverEventPrefix + requestActorEventPrefix + "Spells",
        REQUEST_ACTOR_BASE_DATA:
          serverEventPrefix + requestActorEventPrefix + "BaseData",
        REQUEST_ACTOR_CLASSES:
          serverEventPrefix + requestActorEventPrefix + "Classes",
        REQUEST_ACTOR_TRAITS:
          serverEventPrefix + requestActorEventPrefix + "Traits",
        REQUEST_ACTOR_HEALTH_CHANGE:
          serverEventPrefix + requestActorEventPrefix + "HealthChange",
        REQUEST_ACTOR_LONG_REST:
          serverEventPrefix + requestActorEventPrefix + "LongRest",
        REQUEST_ACTOR_SHORT_REST:
          serverEventPrefix + requestActorEventPrefix + "ShortRest",
      },
      SEND: {
        SEND_ACTOR_ATTRIBUTES:
          serverEventPrefix + sendActorPrefix + "Attributes",
        SEND_ACTOR_ABILITIES: serverEventPrefix + sendActorPrefix + "Abilities",
        SEND_ACTOR_SKILLS: serverEventPrefix + sendActorPrefix + "Skills",
        SEND_ACTOR_SPELL_SLOTS:
          serverEventPrefix + sendActorPrefix + "SpellSlots",
        SEND_ACTOR_INVENTORY: serverEventPrefix + sendActorPrefix + "Inventory",
        SEND_ACTOR_DETAILS: serverEventPrefix + sendActorPrefix + "Details",
        SEND_ACTOR_CURRENCY: serverEventPrefix + sendActorPrefix + "Currency",
        SEND_ACTOR_SPELLS: serverEventPrefix + sendActorPrefix + "Spells",
        SEND_ACTOR_BASE_DATA: serverEventPrefix + sendActorPrefix + "BaseData",
        SEND_ACTOR_CLASSES: serverEventPrefix + sendActorPrefix + "Classes",
        SEND_ACTOR_TRAITS: serverEventPrefix + sendActorPrefix + "Traits",
      },
    },
    ROLL: {
      REQUEST: {
        REQUEST_FOUNDRY_ABILITY_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "AbilityRoll",
        REQUEST_FOUNDRY_SKILL_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "SkillRoll",
        REQUEST_FOUNDRY_ITEM_ATTACK_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "ItemAttackRoll",
        REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "ItemDamageRoll",
        REQUEST_FOUNDRY_ITEM_CONSUME_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "ItemConsumeRoll",
        REQUEST_FOUNDRY_ITEM_TOOL_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "ItemToolRoll",
        REQUEST_FOUNDRY_INITIATIVE_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "InitiativeRoll",
        REQUEST_FOUNDRY_DEATH_SAVE_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "DeathSaveRoll",
        REQUEST_FOUNDRY_HIT_DIE_ROLL:
          serverEventPrefix + requestFoundryEventPrefix + "HitDieRoll",
      },
      SEND: {
        SEND_FOUNDRY_ABILITY_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "AbilityRoll",
        SEND_FOUNDRY_SKILL_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "SkillRoll",
        SEND_FOUNDRY_ITEM_ATTACK_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "ItemAttackRoll",
        SEND_FOUNDRY_ITEM_DAMAGE_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "ItemDamageRoll",
        SEND_FOUNDRY_ITEM_CONSUME_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "ItemConsumeRoll",
        SEND_FOUNDRY_ITEM_TOOL_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "ItemToolRoll",
        SEND_FOUNDRY_INITIATIVE_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "InitiativeRoll",
        SEND_FOUNDRY_DEATH_SAVE_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "DeathSaveRoll",
        SEND_FOUNDRY_HIT_DIE_ROLL:
          serverEventPrefix + sendFoundryEventPrefix + "HitDieRoll",
      },
    },
    DISPLAY: {
      REQUEST: {
        REQUEST_FOUNDRY_CHAT_DATA:
          serverEventPrefix + requestFoundryEventPrefix + "ChatData",
        REQUEST_FOUNDRY_DISPLAY_ITEM:
          serverEventPrefix + requestFoundryEventPrefix + "DisplayItem",
        SEND_FOUNDRY_CHAT_MESSAGE:
          serverEventPrefix + sendFoundryEventPrefix + "ChatMessage",
      },
      SEND: {
        SEND_FOUNDRY_CHAT_DATA:
          serverEventPrefix + sendFoundryEventPrefix + "ChatData",
        SEND_FOUNDRY_CHAT_MESSAGE:
          serverEventPrefix + sendFoundryEventPrefix + "ChatMessage",
      },
    },
  },
  ERROR: {
    GENERAL: {
      ERROR: "error",
    },
    SETUP: {
      JOIN_ROOM: "error:join-room",
    },
    ACTOR: {
      NO_ACTOR_FOR_ID: "error:noActorForId",
    },
  },
  GENERAL: {
    DISCONNECT: "disconnect",
  },
};

export const VALID_EVENTS = new Set(
  Object.values(SOCKET_EVENTS.FOUNDRY.ACTOR).concat(
    Object.values(SOCKET_EVENTS.FOUNDRY.ROLL),
    Object.values(SOCKET_EVENTS.FOUNDRY.SETUP),
    Object.values(SOCKET_EVENTS.FOUNDRY.DISPLAY),
    Object.values(SOCKET_EVENTS.IOS.ROLL),
    Object.values(SOCKET_EVENTS.IOS.SETUP),
    Object.values(SOCKET_EVENTS.IOS.ACTOR),
    Object.values(SOCKET_EVENTS.IOS.DISPLAY),
    Object.values(SOCKET_EVENTS.SERVER.SETUP.REQUEST),
    Object.values(SOCKET_EVENTS.SERVER.SETUP.SEND),
    Object.values(SOCKET_EVENTS.SERVER.ROLL.REQUEST),
    Object.values(SOCKET_EVENTS.SERVER.ROLL.SEND),
    Object.values(SOCKET_EVENTS.SERVER.DISPLAY.REQUEST),
    Object.values(SOCKET_EVENTS.SERVER.DISPLAY.SEND),
    Object.values(SOCKET_EVENTS.SERVER.ACTOR.REQUEST),
    Object.values(SOCKET_EVENTS.SERVER.ACTOR.SEND),
    Object.values(SOCKET_EVENTS.ERROR.GENERAL),
    Object.values(SOCKET_EVENTS.ERROR.SETUP),
    Object.values(SOCKET_EVENTS.ERROR.ACTOR),
    Object.values(SOCKET_EVENTS.GENERAL)
  )
);

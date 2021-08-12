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
    },
    ACTOR: {
      SEND_ACTOR_OVERVIEW: foundryEventPrefix + sendActorPrefix + "Overview",
      SEND_ACTOR_ABILITIES: foundryEventPrefix + sendActorPrefix + "Abilities",
      SEND_ACTOR_SKILLS: foundryEventPrefix + sendActorPrefix + "Skills",
      SEND_ACTOR_SPELL_SLOTS:
        foundryEventPrefix + sendActorPrefix + "SpellSlots",
      SEND_ACTOR_INVENTORY: foundryEventPrefix + sendActorPrefix + "Inventory",
      SEND_ACTOR_BIOGRAPHY: foundryEventPrefix + sendActorPrefix + "Biography",
    },
    ROLL: {
      SEND_ABILITY_ROLL: foundryEventPrefix + "sendAbilityRoll",
      SEND_SKILL_ROLL: foundryEventPrefix + "sendSkillRoll",
      SEND_ITEM_ATTACK_ROLL: foundryEventPrefix + "sendItemAttackRoll",
      SEND_ITEM_DAMAGE_ROLL: foundryEventPrefix + "sendItemDamageRoll",
      SEND_ITEM_CONSUME_ROLL: foundryEventPrefix + "sendItemConsumeRoll",
      SEND_ITEM_TOOL_ROLL: foundryEventPrefix + "sendItemToolRoll",
      SEND_INITIATIVE_ROLL: foundryEventPrefix + "sendInitiativeRoll",
    },
    DISPLAY: {
      SEND_CHAT_DATA: foundryEventPrefix + "sendChatData",
    },
  },
  SERVER: {
    SETUP: {
      REQUEST: {
        REQUEST_FOUNDRY_USERS:
          serverEventPrefix + requestFoundryEventPrefix + "Users",
        REQUEST_FOUNDRY_ACTORS:
          serverEventPrefix + requestFoundryEventPrefix + "Actors",
        REQUEST_FOUNDRY_WORLD_DATA:
          serverEventPrefix + requestFoundryEventPrefix + "WorldData",
      },
    },
    ACTOR: {
      REQUEST: {
        REQUEST_ACTOR_OVERVIEW:
          serverEventPrefix + requestActorEventPrefix + "Overview",
        REQUEST_ACTOR_ABILITIES:
          serverEventPrefix + requestActorEventPrefix + "Abilities",
        REQUEST_ACTOR_SKILLS:
          serverEventPrefix + requestActorEventPrefix + "Skills",
        REQUEST_ACTOR_SPELL_SLOTS:
          serverEventPrefix + requestActorEventPrefix + "SpellSlots",
        REQUEST_ACTOR_INVENTORY:
          serverEventPrefix + requestActorEventPrefix + "Inventory",
        REQUEST_ACTOR_BIOGRAPHY:
          serverEventPrefix + requestActorEventPrefix + "Biography",
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
        REQUEST_FOUNDRY_DISPLAY_ITEM:
          serverEventPrefix + requestFoundryEventPrefix + "DisplayItem",
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
  },
  GENERAL: {
    DISCONNECT: "disconnect",
  },
};

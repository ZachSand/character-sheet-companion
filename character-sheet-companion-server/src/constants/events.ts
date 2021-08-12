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
  IOS: {
    SETUP: {
      JOIN_ROOM: iosEventPrefix + "joinRoom",
      REQUEST_FOUNDRY_USERS:
        iosEventPrefix + requestFoundryEventPrefix + "Users",
      REQUEST_FOUNDRY_ACTORS:
        iosEventPrefix + requestFoundryEventPrefix + "Actors",
      REQUEST_FOUNDRY_WORLD_DATA:
        iosEventPrefix + requestFoundryEventPrefix + "WorldData",
    },
    ACTOR: {
      REQUEST_ACTOR_OVERVIEW:
        iosEventPrefix + requestActorEventPrefix + "Overview",
      REQUEST_ACTOR_ABILITIES:
        iosEventPrefix + requestActorEventPrefix + "Abilities",
      REQUEST_ACTOR_SKILLS: iosEventPrefix + requestActorEventPrefix + "Skills",
      REQUEST_ACTOR_SPELL_SLOTS:
        iosEventPrefix + requestActorEventPrefix + "SpellSlots",
      REQUEST_ACTOR_INVENTORY:
        iosEventPrefix + requestActorEventPrefix + "Inventory",
      REQUEST_ACTOR_BIOGRAPHY:
        iosEventPrefix + requestActorEventPrefix + "Biography",
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
        REQUEST_FOUNDRY_ACTORS:
          serverEventPrefix + requestFoundryEventPrefix + "Actors",
        REQUEST_FOUNDRY_WORLD_DATA:
          serverEventPrefix + requestFoundryEventPrefix + "WorldData",
      },
      SEND: {
        SEND_FOUNDRY_USERS:
          serverEventPrefix + sendFoundryEventPrefix + "Users",
        SEND_FOUNDRY_ACTORS:
          serverEventPrefix + sendFoundryEventPrefix + "Actors",
        SEND_FOUNDRY_WORLD_DATA:
          serverEventPrefix + sendFoundryEventPrefix + "WorldData",
        SEND_IOS_JOINED_ROOM: serverEventPrefix + "sendIosJoinedRoom",
        SEND_FOUNDRY_JOINED_ROOM:
          serverEventPrefix + sendFoundryEventPrefix + "JoinedRoom",
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
      SEND: {
        SEND_ACTOR_OVERVIEW: serverEventPrefix + sendActorPrefix + "Overview",
        SEND_ACTOR_ABILITIES: serverEventPrefix + sendActorPrefix + "Abilities",
        SEND_ACTOR_SKILLS: serverEventPrefix + sendActorPrefix + "Skills",
        SEND_ACTOR_SPELL_SLOTS:
          serverEventPrefix + sendActorPrefix + "SpellSlots",
        SEND_ACTOR_INVENTORY: serverEventPrefix + sendActorPrefix + "Inventory",
        SEND_ACTOR_BIOGRAPHY: serverEventPrefix + sendActorPrefix + "Biography",
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
        SEND_FOUNDRY_DISPLAY_ITEM:
          serverEventPrefix + sendFoundryEventPrefix + "DisplayItem",
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
    Object.values(SOCKET_EVENTS.GENERAL)
  )
);

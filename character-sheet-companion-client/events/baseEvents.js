import { CORE_EVENTS } from "./coreEvents.js";
import { EVENT_TYPES } from "./eventTypes.js";

export const BASE_EVENTS = {
  SETUP: {
    JOIN_ROOM: EVENT_TYPES.GENERAL.SETUP + CORE_EVENTS.JOIN_ROOM,
    WORLD_USERS: EVENT_TYPES.GENERAL.SETUP + CORE_EVENTS.WORLD_USERS,
    WORLD_DATA: EVENT_TYPES.GENERAL.SETUP + CORE_EVENTS.WORLD_DATA,
    WORLD_USER_AUTH: EVENT_TYPES.GENERAL.SETUP + CORE_EVENTS.WORLD_USER_AUTH,
    COMPLETE: EVENT_TYPES.GENERAL.SETUP + CORE_EVENTS.COMPLETE,
  },
  ACTOR: {
    ATTRIBUTES: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.ATTRIBUTES,
    ABILITIES: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.ABILITIES,
    SKILLS: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.SKILLS,
    SPELL_SLOTS: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.SPELL_SLOTS,
    INVENTORY: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.INVENTORY,
    DETAILS: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.DETAILS,
    CURRENCY: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.CURRENCY,
    SPELLS: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.SPELLS,
    BASE_DATA: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.BASE_DATA,
    CLASSES: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.CLASSES,
    TRAITS: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.TRAITS,
  },
  ACTOR_CHANGE: {
    HEALTH: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.HEALTH,
    LONG_REST: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.LONG_REST,
    SHORT_REST: EVENT_TYPES.GENERAL.ACTOR + CORE_EVENTS.SHORT_REST,
  },
  ROLL: {
    ABILITY: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.ABILITY,
    SKILL: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.SKILL,
    ITEM_ATTACK: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.ITEM_ATTACK,
    ITEM_DAMAGE: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.ITEM_DAMAGE,
    ITEM_CONSUME: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.ITEM_CONSUME,
    ITEM_TOOL: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.ITEM_TOOL,
    INITIATIVE: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.INITIATIVE,
    DEATH_SAVE: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.DEATH_SAVE,
    HIT_DIE: EVENT_TYPES.GENERAL.ROLL + CORE_EVENTS.HIT_DIE,
  },
  DISPLAY: {
    CHAT_DATA: EVENT_TYPES.GENERAL.DISPLAY + CORE_EVENTS.CHAT_DATA,
    CHAT_MESSAGE: EVENT_TYPES.GENERAL.DISPLAY + CORE_EVENTS.CHAT_MESSAGE,
    ITEM: EVENT_TYPES.GENERAL.DISPLAY + CORE_EVENTS.ITEM,
  },
};

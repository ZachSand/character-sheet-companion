import { BASE_EVENTS } from "../baseEvents.js";
import { EVENT_TYPES } from "../eventTypes.js";

export class FoundrySocketEvents {
  static _instance;
  FOUNDRY_EVENTS = {
    SETUP: {
      JOIN_ROOM: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.SETUP.JOIN_ROOM,
      WORLD_USERS: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.SETUP.WORLD_USERS,
      WORLD_DATA: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.SETUP.WORLD_DATA,
      WORLD_USER_AUTH:
        EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.SETUP.WORLD_USER_AUTH,
    },
    ACTOR: {
      ATTRIBUTES: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.ATTRIBUTES,
      ABILITIES: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.ABILITIES,
      SKILLS: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.SKILLS,
      SPELL_SLOTS: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.SPELL_SLOTS,
      INVENTORY: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.INVENTORY,
      DETAILS: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.DETAILS,
      CURRENCY: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.CURRENCY,
      SPELLS: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.SPELLS,
      BASE_DATA: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.BASE_DATA,
      CLASSES: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.CLASSES,
      TRAITS: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ACTOR.TRAITS,
    },
    ROLL: {
      ABILITY: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.ABILITY,
      SKILL: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.SKILL,
      ITEM_ATTACK: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.ITEM_ATTACK,
      ITEM_DAMAGE: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.ITEM_DAMAGE,
      ITEM_CONSUME: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.ITEM_CONSUME,
      ITEM_TOOL: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.ITEM_TOOL,
      INITIATIVE: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.INITIATIVE,
      DEATH_SAVE: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.DEATH_SAVE,
      HIT_DIE: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.ROLL.HIT_DIE,
    },
    DISPLAY: {
      CHAT_DATA: EVENT_TYPES.SOCKET.FOUNDRY + BASE_EVENTS.DISPLAY.CHAT_DATA,
    },
  };

  static get Instance() {
    return this._instance || (this._instance = new this());
  }

  getFromBaseEvent(event) {
    return EVENT_TYPES.SOCKET.FOUNDRY + event;
  }
}

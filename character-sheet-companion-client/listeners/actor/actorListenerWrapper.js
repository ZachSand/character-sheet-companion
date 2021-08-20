import { SOCKET_EVENTS } from "../../constants/events.js";
import { createAndEmitActorInventory } from "./actorInventoryListener.js";
import {
  applyHealthChange,
  createAndEmitActorAttributes,
} from "./actorAttributesListener.js";
import { createAndEmitActorDetails } from "./actorDetailsListener.js";
import { createAndEmitActorAbilities } from "./actorAbilityListener.js";
import { createAndEmitActorSkills } from "./actorSkillListener.js";
import { createAndEmitActorSpellSlots } from "./actorSpellSlotListener.js";
import { createAndEmitActorCurrency } from "./actorCurrencyListener.js";
import { createAndEmitActorSpells } from "./actorSpellListener.js";
import { createAndEmitActorBaseData } from "./actorBaseDataListener.js";
import { createAndEmitActorClasses } from "./actorClassesListener.js";
import { createAndEmitActorTraits } from "./actorTraitsListener.js";

export function actorListenerWrapper(socket) {
  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_ATTRIBUTES,
    (actorId, iosSocketId) => {
      createAndEmitActorAttributes(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_HEALTH_CHANGE,
    (actorId, healthChange, iosSocketId) => {
      applyHealthChange(socket, actorId, healthChange, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_INVENTORY,
    async (actorId, iosSocketId) => {
      await createAndEmitActorInventory(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_ABILITIES,
    (actorId, iosSocketId) => {
      createAndEmitActorAbilities(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SKILLS,
    (actorId, iosSocketId) => {
      createAndEmitActorSkills(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SPELL_SLOTS,
    (actorId, iosSocketId) => {
      createAndEmitActorSpellSlots(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_DETAILS,
    (actorId, iosSocketId) => {
      createAndEmitActorDetails(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_CURRENCY,
    (actorId, iosSocketId) => {
      createAndEmitActorCurrency(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SPELLS,
    async (actorId, iosSocketId) => {
      await createAndEmitActorSpells(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_BASE_DATA,
    async (actorId, iosSocketId) => {
      await createAndEmitActorBaseData(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_CLASSES,
    (actorId, iosSocketId) => {
      createAndEmitActorClasses(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_TRAITS,
    (actorId, iosSocketId) => {
      createAndEmitActorTraits(socket, actorId, iosSocketId);
    }
  );
}

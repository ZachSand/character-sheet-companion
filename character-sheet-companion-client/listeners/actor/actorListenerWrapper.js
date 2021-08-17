import { SOCKET_EVENTS } from "../../constants/events.js";
import { createAndEmitInventory } from "./actorInventoryListener.js";
import { createAndEmitActorOverview } from "./actorOverviewListener.js";
import { createAndEmitActorBiography } from "./actorBiographyListener.js";
import { createAndEmitActorAbilities } from "./actorAbilityListener.js";
import { createAndEmitSkills } from "./actorSkillListener.js";
import { createAndEmitSpellSlots } from "./actorSpellSlotListener.js";
import { createAndEmitCurrency } from "./actorCurrencyListener.js";
import { createAndEmitSpells } from "./actorSpellListener.js";

export function actorListenerWrapper(socket) {
  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_OVERVIEW,
    async (actorId, iosSocketId) => {
      await createAndEmitActorOverview(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_INVENTORY,
    async (actorId, iosSocketId) => {
      await createAndEmitInventory(socket, actorId, iosSocketId);
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
      createAndEmitSkills(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SPELL_SLOTS,
    (actorId, iosSocketId) => {
      createAndEmitSpellSlots(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_BIOGRAPHY,
    async (actorId, iosSocketId) => {
      await createAndEmitActorBiography(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_CURRENCY,
    (actorId, iosSocketId) => {
      createAndEmitCurrency(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SPELLS,
    async (actorId, iosSocketId) => {
      await createAndEmitSpells(socket, actorId, iosSocketId);
    }
  );
}

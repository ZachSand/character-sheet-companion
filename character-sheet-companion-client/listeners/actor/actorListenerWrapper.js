import { SOCKET_EVENTS } from "../../events/events.js";
import { createAndEmitInventory } from "./actorInventoryListener.js";
import { createAndEmitActorOverview } from "./actorOverviewListener.js";
import { createAndEmitActorBiography } from "./actorBiographyListener.js";
import { createAndEmitActorAbilities } from "./actorAbilityListener.js";
import { createAndEmitSkills } from "./actorSkillListener.js";
import { createAndEmitSpellSlots } from "./actorSpellSlotListener.js";

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
    async (actorId, iosSocketId) => {
      await createAndEmitActorAbilities(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SKILLS,
    async (actorId, iosSocketId) => {
      await createAndEmitSkills(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SPELL_SLOTS,
    async (actorId, iosSocketId) => {
      await createAndEmitSpellSlots(socket, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_BIOGRAPHY,
    async (actorId, iosSocketId) => {
      await createAndEmitActorBiography(socket, actorId, iosSocketId);
    }
  );
}

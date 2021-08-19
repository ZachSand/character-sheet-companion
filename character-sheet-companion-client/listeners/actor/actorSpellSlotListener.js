import { SOCKET_EVENTS } from "../../constants/events.js";
import { getActorOrEmitError } from "../../utils/commonUtilities.js";

export function createAndEmitActorSpellSlots(socket, actorId, iosSocketId) {
  let actor = getActorOrEmitError(socket, actorId, iosSocketId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_SPELL_SLOTS,
      Object.entries(actor.data.data.spells).map((spellSlotEntry) => {
        let spellId = spellSlotEntry[0];
        let spellSlot = spellSlotEntry[1];
        let spellLevel =
          spellId === "pact"
            ? spellSlot.level
            : Number(spellId.split("spell")[1]);
        return {
          id: spellId,
          spellLevel: spellLevel,
          spellLevelLabel: CONFIG.DND5E.spellLevels[spellLevel],
          maxSpellSlots: spellSlot.max,
          currentSpellSlots: spellSlot.value,
          isPact: spellId === "pact",
        };
      }),
      iosSocketId
    );
  }
}

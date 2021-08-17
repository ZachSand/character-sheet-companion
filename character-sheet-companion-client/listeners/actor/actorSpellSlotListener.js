import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitSpellSlots(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
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

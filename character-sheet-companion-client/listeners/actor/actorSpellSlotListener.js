import {
  getBase64ImageData,
  removeBase64Metadata,
  removeHtml,
} from "../../utils/commonUtilities.js";
import { SOCKET_EVENTS } from "../../events/events.js";

export async function createAndEmitSpellSlots(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_SPELL_SLOTS,
      await Promise.all(
        Object.entries(actor.data.data.spells).map(async (spellSlotEntry) => {
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
            spells: await Promise.all(
              actor.items
                .filter((item) => item.type === "spell")
                .filter((spell) => spell.data.data.level === spellLevel)
                .map(async (spell) => {
                  return {
                    id: spell.data._id,
                    name: spell.data.name,
                    description: removeHtml(spell.data.data.description.value),
                    spellLevel: spell.data.data.level,
                    hasAttack: spell.hasAttack,
                    hasDamage: spell.hasDamage,
                    isHealing: spell.isHealing !== false,
                    prepared:
                      spell.data.data.level > 0 &&
                      spell.data.data.preparation.mode === "prepared" &&
                      spell.data.data.preparation.prepared,
                    image: await getBase64ImageData(spell.data.img).then(
                      (imageData) => {
                        return removeBase64Metadata(imageData);
                      }
                    ),
                  };
                })
            ),
          };
        })
      ),
      iosSocketId
    );
  }
}

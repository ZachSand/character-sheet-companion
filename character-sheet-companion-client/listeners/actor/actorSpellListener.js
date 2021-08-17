import { SOCKET_EVENTS } from "../../constants/events.js";
import {
  getBase64ImageData,
  removeBase64Metadata,
  removeHtml,
} from "../../utils/commonUtilities.js";

export async function createAndEmitSpells(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_SPELLS,
      await Promise.all(
        actor.items
          .filter((item) => item.type === "spell")
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
      iosSocketId
    );
  }
}

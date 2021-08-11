import {
  getBase64ImageData,
  removeBase64Metadata,
} from "../../utils/commonUtilities.js";
import { SOCKET_EVENTS } from "../../events/events.js";

export async function createAndEmitActorOverview(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    let actorOverview = {
      id: actorId,
      name: actor.name,
      armorClass: actor.data.data.attributes.ac.value,
      currentHealth: actor.data.data.attributes.hp.value,
      maxHealth: actor.data.data.attributes.hp.max,
      proficiencyBonus: actor.data.data.prof,
      initiativeBonus: actor.data.data.attributes.init.total,
      mainClass: actor.items.get(actor.data.data.details.originalClass).name,
      overallLevel: actor.data.data.details.level,
    };

    await getBase64ImageData(actor.img).then((imageData) => {
      actorOverview.imageData = removeBase64Metadata(imageData.split(",")[1]);
    });

    socket.emit(
      SOCKET_EVENTS.FOUNDRY.SEND_ACTOR_OVERVIEW,
      actorOverview,
      iosSocketId
    );
  }
}

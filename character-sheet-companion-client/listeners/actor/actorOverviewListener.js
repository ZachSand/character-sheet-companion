import {
  getBase64ImageData,
  removeBase64Metadata,
} from "../../utils/commonUtilities.js";
import { SOCKET_EVENTS } from "../../events/events.js";

export async function createAndEmitActorOverview(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_OVERVIEW,
      {
        id: actorId,
        name: actor.name,
        armorClass: actor.data.data.attributes.ac.value,
        currentHealth: actor.data.data.attributes.hp.value,
        maxHealth: actor.data.data.attributes.hp.max,
        proficiencyBonus: actor.data.data.prof,
        initiativeBonus: actor.data.data.attributes.init.total,
        mainClass: actor.items.get(actor.data.data.details.originalClass).data
          .name,
        overallLevel: actor.data.data.details.level,
        imageData: await getBase64ImageData(actor.img).then((imageData) => {
          return removeBase64Metadata(imageData);
        }),
      },
      iosSocketId
    );
  }
}

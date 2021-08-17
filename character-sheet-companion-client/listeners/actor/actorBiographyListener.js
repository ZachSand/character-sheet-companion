import { removeHtml } from "../../utils/commonUtilities.js";
import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitActorBiography(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_BIOGRAPHY,
      {
        biography: removeHtml(actor.data.data.details.biography.value),
        appearance: removeHtml(actor.data.data.details.appearance),
        flaws: removeHtml(actor.data.data.details.flaw),
        bonds: removeHtml(actor.data.data.details.bond),
        personalityTraits: removeHtml(actor.data.data.details.trait),
        ideals: removeHtml(actor.data.data.details.ideal),
      },
      iosSocketId
    );
  }
}

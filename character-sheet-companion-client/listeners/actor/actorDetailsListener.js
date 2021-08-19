import {
  getActorOrEmitError,
  removeHtml,
} from "../../utils/commonUtilities.js";
import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitActorDetails(socket, actorId, iosSocketId) {
  let actor = getActorOrEmitError(socket, actorId, iosSocketId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_DETAILS,
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

import { SOCKET_EVENTS } from "../../constants/events.js";
import {
  getActorOrEmitError,
  removeHtml,
} from "../../utils/commonUtilities.js";

export function createAndEmitActorClasses(socket, actorId, iosSocketId) {
  let actor = getActorOrEmitError(socket, actorId, iosSocketId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_CLASSES,
      Object.keys(actor.data.data.classes).map((className) => {
        let actorClass = actor.data.data.classes[className];
        return {
          id: className,
          description: removeHtml(actorClass.description.value),
          levels: actorClass.levels,
          subclass: actorClass.subclass,
        };
      }),
      iosSocketId
    );
  }
}

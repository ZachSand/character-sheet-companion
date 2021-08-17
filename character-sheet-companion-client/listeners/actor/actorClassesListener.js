import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitActorClasses(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_CLASSES,
      Object.keys(actor.data.data.classes).map((className) => {
        let actorClass = actor.data.data.classes[className];
        return {
          id: className,
          description: actorClass.description,
          levels: actorClass.levels,
          subclass: actorClass.subclass,
        };
      }),
      iosSocketId
    );
  }
}

import { SOCKET_EVENTS } from "../../events/events.js";

export function getAndEmitActors(socket, iosSocketId) {
  let gameActors = game.actors.filter((actor) => actor.type === "character");
  let actorsToRespond = [];
  gameActors.forEach((actor) => {
    let actorToRespond = {
      actorId: actor.data._id,
      name: actor.data.name,
    };
    actorsToRespond.push(actorToRespond);
  });
  socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_ACTORS, actorsToRespond, iosSocketId);
}

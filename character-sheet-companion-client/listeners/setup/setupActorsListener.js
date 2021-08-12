import { SOCKET_EVENTS } from "../../events/events.js";

export function getAndEmitActors(socket, iosSocketId) {
  socket.emit(
    SOCKET_EVENTS.FOUNDRY.SETUP.SEND_ACTORS,
    game.actors
      .filter((actor) => actor.type === "character")
      .map((actor) => {
        return {
          id: actor.data._id,
          name: actor.data.name,
        };
      }),
    iosSocketId
  );
}

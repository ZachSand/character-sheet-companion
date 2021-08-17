import { SOCKET_EVENTS } from "../../constants/events.js";

export function getAndEmitUsers(socket, iosSocketId) {
  socket.emit(
    SOCKET_EVENTS.FOUNDRY.SETUP.SEND_USERS,
    game.users.map((user) => {
      return {
        id: user.data._id,
        isActive: user.active,
        name: user.data.name,
        actors: game.actors
          .filter((actor) => actor.type === "character")
          .filter((actor) => actor.testUserPermission(user, "OWNER"))
          .map((actor) => {
            return {
              id: actor.data._id,
              name: actor.data.name,
            };
          }),
      };
    }),
    iosSocketId
  );
}

import { SOCKET_EVENTS } from "../../events/events.js";

export function getAndEmitUsers(socket, iosSocketId) {
  socket.emit(
    SOCKET_EVENTS.FOUNDRY.SEND_USERS,
    game.users.map((user) => {
      return {
        id: user.data._id,
        isActive: user.active,
        name: user.data.name,
      };
    }),
    iosSocketId
  );
}

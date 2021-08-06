import { SOCKET_EVENTS } from "../../events/events.js";

export function getAndEmitUsers(socket, iosSocketId) {
  let users = [];
  game.users.forEach((user) => {
    let userModel = {
      userId: user.data._id,
      isActive: user.active,
      userName: user.data.name,
    };
    users.push(userModel);
  });
  socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_USERS, users, iosSocketId);
}

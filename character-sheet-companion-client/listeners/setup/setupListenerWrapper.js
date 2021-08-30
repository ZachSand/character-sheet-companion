import { SOCKET_EVENTS } from "../../constants/events.js";
import { getAndEmitUsers } from "./setupUsersListener.js";
import { getAndEmitWorldData } from "./setupWorldDataListener.js";
import { handleSocketConnect } from "./setupConnectionListener.js";
import { setupIosCompleteListener } from "./setupIosCompleteListener.js";
import { userAuthListener } from "./setupUserAuthenticationListener.js";

export function setupListenerWrapper(socket) {
  handleSocketConnect(socket);

  socket.on(
    SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_USERS,
    (iosSocketId) => {
      getAndEmitUsers(socket, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_WORLD_DATA,
    (iosSocketId) => {
      getAndEmitWorldData(socket, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.SETUP.SEND.SEND_IOS_SETUP_COMPLETE,
    (actorId, userId, iosSocketId) => {
      setupIosCompleteListener(actorId, userId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_USER_AUTH,
    async (setupUserAuth, iosSocketId) => {
      await userAuthListener(socket, setupUserAuth, iosSocketId);
    }
  );
}

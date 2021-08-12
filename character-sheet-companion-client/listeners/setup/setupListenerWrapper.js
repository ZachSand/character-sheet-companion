import { SOCKET_EVENTS } from "../../events/events.js";
import { getAndEmitUsers } from "./setupUsersListener.js";
import { getAndEmitActors } from "./setupActorsListener.js";
import { getAndEmitWorldData } from "./setupWorldDataListener.js";

export function setupListenerWrapper(socket) {
  socket.on(
    SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_USERS,
    (iosSocketId) => {
      getAndEmitUsers(socket, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_ACTORS,
    (iosSocketId) => {
      getAndEmitActors(socket, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_WORLD_DATA,
    (iosSocketId) => {
      getAndEmitWorldData(socket, iosSocketId);
    }
  );
}

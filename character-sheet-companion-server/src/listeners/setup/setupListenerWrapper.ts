import { Server, Socket } from "socket.io";
import { setupUsersListener } from "./setupUsersListener";
import { setupActorsListener } from "./setupActorsListener";
import { setupWorldDataListener } from "./setupWorldDataListener";
import { setupRoomJoinListener } from "./setupRoomJoinListener";

export const setupListenerWrapper = (io: Server, socket: Socket): void => {
  setupUsersListener(io, socket);
  setupActorsListener(io, socket);
  setupWorldDataListener(io, socket);
  setupRoomJoinListener(io, socket);
};

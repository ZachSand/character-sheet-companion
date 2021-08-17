import { Server, Socket } from "socket.io";
import { setupUsersListener } from "./setupUsersListener";
import { setupWorldDataListener } from "./setupWorldDataListener";
import { setupRoomJoinListener } from "./setupRoomJoinListener";
import { setupIosCompleteListener } from "./setupIosCompleteListener";
import { setupUserAuthenticationListener } from "./setupUserAuthenticationListener";

export const setupListenerWrapper = (io: Server, socket: Socket): void => {
  setupUsersListener(io, socket);
  setupWorldDataListener(io, socket);
  setupRoomJoinListener(io, socket);
  setupIosCompleteListener(io, socket);
  setupUserAuthenticationListener(io, socket);
};

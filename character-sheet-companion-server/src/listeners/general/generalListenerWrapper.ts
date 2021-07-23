import { authorizationListener } from "./authorizationListener";
import { errorListener } from "./errorListener";
import { disconnectListener } from "./disconnectListener";
import { roomJoinListener } from "./roomJoinListener";
import { Server, Socket } from "socket.io";

export const generalListenerWrapper = (io: Server, socket: Socket): void => {
  authorizationListener(io, socket);
  errorListener(io, socket);
  disconnectListener(io, socket);
  roomJoinListener(io, socket);
};

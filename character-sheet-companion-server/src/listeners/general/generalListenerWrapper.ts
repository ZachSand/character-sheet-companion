import { generalAuthorizationListener } from "./generalAuthorizationListener";
import { generalErrorListener } from "./generalErrorListener";
import { generalDisconnectListener } from "./generalDisconnectListener";
import { Server, Socket } from "socket.io";

export const generalListenerWrapper = (io: Server, socket: Socket): void => {
  generalAuthorizationListener(io, socket);
  generalErrorListener(io, socket);
  generalDisconnectListener(io, socket);
};

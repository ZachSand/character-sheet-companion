import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";
import Logger from "../../loaders/logger";

export const generalDisconnectListener = (io: Server, socket: Socket): void => {
  socket.on(SOCKET_EVENTS.GENERAL.DISCONNECT, (reason) => {
    Logger.debug(`Client disconnected due to: ${reason}`);
  });
};

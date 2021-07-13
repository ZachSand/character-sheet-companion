import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../constants/events";
import { ERROR_MESSAGES } from "../constants/error-messages";

export const socketErrorListener = (io: Server, socket: Socket): void => {
  socket.on(SOCKET_EVENTS.ERROR.GENERAL_ERROR, (err) => {
    if (err && err.message === ERROR_MESSAGES.UNAUTHORIZED_EVENT) {
      socket.disconnect();
    }
  });
};

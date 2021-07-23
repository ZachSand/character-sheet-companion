import { Server, Socket } from "socket.io";
import { VALID_EVENTS } from "../../constants/events";
import { ERROR_MESSAGES } from "../../constants/error-messages";
import Logger from "../../loaders/logger";

export const authorizationListener = (io: Server, socket: Socket): void => {
  socket.use(([event], next) => {
    if (!VALID_EVENTS.has(event)) {
      Logger.error(`Received invalid event: ${event}`);
      return next(new Error(ERROR_MESSAGES.UNAUTHORIZED_EVENT));
    }
    next();
  });
};

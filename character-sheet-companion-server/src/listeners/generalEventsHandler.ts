import { Server, Socket } from "socket.io";
import Logger from "../loaders/logger";
import { ERROR_MESSAGES } from "../constants/error-messages";
import { ServerSocketSendEvents } from "../events/socket/ServerSocketSendEvents";
import { ServerSocketRequestEvents } from "../events/socket/ServerSocketRequestEvents";
import { IosSocketEvents } from "../events/socket/IosSocketEvents";
import { FoundrySocketEvents } from "../events/socket/FoundrySocketEvents";
import { GeneralSocketEvents } from "../events/socket/GeneralSocketEvents";
import { ErrorSocketEvents } from "../events/socket/ErrorSocketEvents";

export const generalEventsHandler = (io: Server, socket: Socket): void => {
  socket.use(([event], next) => {
    if (!VALID_EVENTS.has(event)) {
      Logger.error(`Received invalid event: ${event}`);
      return next(new Error(ERROR_MESSAGES.UNAUTHORIZED_EVENT));
    }
    next();
  });

  const VALID_EVENTS = new Set(
    ServerSocketSendEvents.Instance.getEvents().concat(
      ServerSocketRequestEvents.Instance.getEvents(),
      IosSocketEvents.Instance.getEvents(),
      FoundrySocketEvents.Instance.getEvents(),
      GeneralSocketEvents.Instance.getEvents(),
      ErrorSocketEvents.Instance.getEvents()
    )
  );

  socket.on(ErrorSocketEvents.Instance.ERROR_EVENTS.GENERAL.ERROR, (err) => {
    if (err && err.message === ERROR_MESSAGES.UNAUTHORIZED_EVENT) {
      socket.disconnect();
    }
  });

  socket.on(
    GeneralSocketEvents.Instance.GENERAL_EVENTS.DISCONNECT,
    (reason) => {
      Logger.debug(`Client disconnected due to: ${reason}`);
    }
  );
};

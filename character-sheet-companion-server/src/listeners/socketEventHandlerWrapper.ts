import { Server, Socket } from "socket.io";
import Logger from "../loaders/logger";
import { generalEventsHandler } from "./generalEventsHandler";
import { rollEventsHandler } from "./rollEventsHandler";
import { setupEventsHandler } from "./setupEventsHandler";
import { displayEventsHandler } from "./displayEventsHandler";
import { actorEventsHandler } from "./actorEventsHandler";
import { actorChangeEventsHandler } from "./actorChangeEventsHandler";

export const socketEventHandlerWrapper = (io: Server, socket: Socket): void => {
  Logger.debug(`Client socket connected: ${socket.id}`);

  generalEventsHandler(io, socket);
  rollEventsHandler(io, socket);
  setupEventsHandler(io, socket);
  displayEventsHandler(io, socket);
  actorEventsHandler(io, socket);
  actorChangeEventsHandler(io, socket);

  if (Logger.isDebugEnabled()) {
    socket.onAny((event) => {
      Logger.debug(`Received event: ${event} from socket: ${socket.id}`);
    });
  }
};

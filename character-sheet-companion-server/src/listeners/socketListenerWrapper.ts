import { Server, Socket } from "socket.io";
import Logger from "../loaders/logger";
import { generalListenerWrapper } from "./general/generalListenerWrapper";
import { rollListenerWrapper } from "./rolls/rollListenerWrapper";
import { setupListenerWrapper } from "./setup/setupListenerWrapper";
import { displayListenerWrapper } from "./display/displayListenerWrapper";
import { actorListenerWrapper } from "./actor/actorListenerWrapper";

export const socketHandlerWrapper = (io: Server, socket: Socket): void => {
  Logger.debug(`Client socket connected: ${socket.id}`);

  generalListenerWrapper(io, socket);
  rollListenerWrapper(io, socket);
  setupListenerWrapper(io, socket);
  displayListenerWrapper(io, socket);
  actorListenerWrapper(io, socket);

  if (Logger.isDebugEnabled()) {
    socket.onAny((event) => {
      Logger.debug(`Received event: ${event} from socket: ${socket.id}`);
    });
  }
};

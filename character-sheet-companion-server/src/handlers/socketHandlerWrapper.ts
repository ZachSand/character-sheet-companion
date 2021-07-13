import { Server, Socket } from "socket.io";
import Logger from "../loaders/logger";
import { foundryRoomJoinListener } from "./foundryRoomJoinHandler";
import { foundryUserListener } from "./foundryUserHandler";
import { foundryUserActorListener } from "./foundryUserActorHandler";
import { foundryActorDataListener } from "./foundryActorDataListener";
import { validEventListener } from "./socketAuthorizationHandler";
import { socketErrorListener } from "./socketErrorHandler";
import { socketDisconnectListener } from "./socketDisconnectHandler";

export const socketHandlerWrapper = (io: Server, socket: Socket): void => {
  Logger.debug(`Client socket connected: ${socket.id}`);

  // Foundry Events
  foundryRoomJoinListener(io, socket);
  foundryUserListener(io, socket);
  foundryUserActorListener(io, socket);
  foundryActorDataListener(io, socket);

  // Common Events
  validEventListener(io, socket);
  socketErrorListener(io, socket);
  socketDisconnectListener(io, socket);

  if (Logger.isDebugEnabled()) {
    socket.onAny((event) => {
      Logger.debug(`Received event: ${event} from socket: ${socket.id}`);
    });
  }
};

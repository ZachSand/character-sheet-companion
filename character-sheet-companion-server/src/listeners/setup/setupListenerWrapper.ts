import { Server, Socket } from "socket.io";
import { userListener } from "./userHandler";
import { userActorListener } from "./userActorHandler";
import { actorDataListener } from "./actorDataListener";
import { worldDataListener } from "./worldDataListener";

export const setupListenerWrapper = (io: Server, socket: Socket): void => {
  userListener(io, socket);
  userActorListener(io, socket);
  actorDataListener(io, socket);
  worldDataListener(io, socket);
};

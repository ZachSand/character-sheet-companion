import { Server, Socket } from "socket.io";
import { userListener } from "./usersListener";
import { actorListener } from "./actorsListener";
import { actorDataListener } from "./actorDataListener";
import { worldDataListener } from "./worldDataListener";

export const setupListenerWrapper = (io: Server, socket: Socket): void => {
  userListener(io, socket);
  actorListener(io, socket);
  actorDataListener(io, socket);
  worldDataListener(io, socket);
};

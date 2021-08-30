import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorClasses } from "../../interfaces/actor/ActorClasses";

export const actorClassesListener = (io: Server, socket: Socket): void => {
  const requestActorClasses = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_CLASSES,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorClasses = (
    actorClasses: ActorClasses,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_CLASSES,
        JSON.stringify(actorClasses)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_CLASSES, requestActorClasses);
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_CLASSES,
    receiveActorClasses
  );
};

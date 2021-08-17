import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorAttributes } from "../../interfaces/actor/ActorAttributes";

export const actorAttributesListener = (io: Server, socket: Socket): void => {
  const requestActorAttributes = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_ATTRIBUTES,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorAttributes = (
    actorAttributes: ActorAttributes,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_ATTRIBUTES,
        JSON.stringify(actorAttributes)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_ATTRIBUTES,
    requestActorAttributes
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_ATTRIBUTES,
    receiveActorAttributes
  );
};

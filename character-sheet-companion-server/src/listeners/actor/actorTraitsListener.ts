import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorTraits } from "../../interfaces/actor/ActorTraits";

export const actorTraitsListener = (io: Server, socket: Socket): void => {
  const requestActorTraits = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_TRAITS,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorTraits = (
    actorTraits: ActorTraits,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_TRAITS,
        JSON.stringify(actorTraits)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_TRAITS, requestActorTraits);
  socket.on(SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_TRAITS, receiveActorTraits);
};

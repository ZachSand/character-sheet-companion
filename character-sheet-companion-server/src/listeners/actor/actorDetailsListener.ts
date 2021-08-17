import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorDetails } from "../../interfaces/actor/ActorDetails";

export const actorDetailsListener = (io: Server, socket: Socket): void => {
  const requestActorDetails = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_DETAILS,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorDetails = (details: ActorDetails, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_DETAILS,
        JSON.stringify(details)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_DETAILS, requestActorDetails);
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_DETAILS,
    receiveActorDetails
  );
};

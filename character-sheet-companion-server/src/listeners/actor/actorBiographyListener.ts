import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorBiography } from "../../interfaces/actor/ActorBiography";

export const actorBiographyListener = (io: Server, socket: Socket): void => {
  const requestActorBiography = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_BIOGRAPHY,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorBiography = (
    biography: ActorBiography,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_BIOGRAPHY,
        JSON.stringify(biography)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_BIOGRAPHY,
    requestActorBiography
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_BIOGRAPHY,
    receiveActorBiography
  );
};

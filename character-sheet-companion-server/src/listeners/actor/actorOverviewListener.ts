import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorOverview } from "../../interfaces/actor/ActorOverview";

export const actorOverviewListener = (io: Server, socket: Socket): void => {
  const requestActorOverview = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_OVERVIEW,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorOverview = (
    actorOverview: ActorOverview,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_OVERVIEW,
        JSON.stringify(actorOverview)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_OVERVIEW,
    requestActorOverview
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_OVERVIEW,
    receiveActorOverview
  );
};

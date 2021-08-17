import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorBaseData } from "../../interfaces/actor/ActorBaseData";

export const actorBaseDataListener = (io: Server, socket: Socket): void => {
  const requestActorBaseData = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_BASE_DATA,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorBaseData = (
    actorBaseData: ActorBaseData,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_BASE_DATA,
        JSON.stringify(actorBaseData)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_BASE_DATA,
    requestActorBaseData
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_BASE_DATA,
    receiveActorBaseData
  );
};

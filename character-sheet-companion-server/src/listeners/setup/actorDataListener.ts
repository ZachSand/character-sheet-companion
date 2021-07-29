import { Server, Socket } from "socket.io";
import {
  getIosSocketFromRoom,
  getFoundrySocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { Actor } from "../../interfaces/Actor";

export const actorDataListener = (io: Server, socket: Socket): void => {
  const getFoundryActorData = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ACTOR_DATA,
        actorId,
        socket.id
      );
    }
  };

  const receiveFoundryActorData = (actor: Actor, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_ACTOR_DATA,
        JSON.stringify(actor)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_ACTOR_DATA, getFoundryActorData);
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_ACTOR_DATA, receiveFoundryActorData);
};

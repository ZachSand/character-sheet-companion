import { Server, Socket } from "socket.io";
import { getSocketFromRoom } from "../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../constants/events";
import { Actor } from "../interfaces/Actor";

export const foundryActorDataListener = (io: Server, socket: Socket): void => {
  const getFoundryActorData = (actorId: string) => {
    const foundrySocket = getSocketFromRoom(io, socket, true);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ACTOR_DATA,
        actorId
      );
    }
  };

  const receiveFoundryActorData = (actor: Actor) => {
    const iosSocket = getSocketFromRoom(io, socket, false);
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

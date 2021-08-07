import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { Actor } from "../../interfaces/setup/Actor";

export const actorListener = (io: Server, socket: Socket): void => {
  const getFoundryActors = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USER_ACTORS,
        socket.id
      );
    }
  };

  const receiveFoundryActors = (actors: Actor[], iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_USER_ACTORS,
        JSON.stringify(actors)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_ACTORS, getFoundryActors);
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_ACTORS, receiveFoundryActors);
};

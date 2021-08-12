import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { Actor } from "../../interfaces/setup/Actor";

export const setupActorsListener = (io: Server, socket: Socket): void => {
  const getFoundryActors = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_ACTORS,
        socket.id
      );
    }
  };

  const receiveFoundryActors = (actors: Actor[], iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.SEND.SEND_FOUNDRY_ACTORS,
        JSON.stringify(actors)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.SETUP.REQUEST_FOUNDRY_ACTORS, getFoundryActors);
  socket.on(SOCKET_EVENTS.FOUNDRY.SETUP.SEND_ACTORS, receiveFoundryActors);
};

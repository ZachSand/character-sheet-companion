import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";
import {
  getIosSocketFromRoom,
  getFoundrySocketFromRoom,
} from "../../utilities/SocketUtilities";
import { UserActor } from "../../interfaces/setup/UserActor";

export const userActorListener = (io: Server, socket: Socket): void => {
  const getFoundryUserActors = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USER_ACTORS,
        socket.id
      );
    }
  };

  const receiveFoundryUserActors = (
    userActors: UserActor[],
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_USER_ACTORS,
        JSON.stringify(userActors)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_USER_ACTORS,
    getFoundryUserActors
  );
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_USER_ACTORS, receiveFoundryUserActors);
};

import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../constants/events";
import { getSocketFromRoom } from "../utilities/SocketUtilities";
import { UserActor } from "../interfaces/UserActor";

export const foundryUserActorListener = (io: Server, socket: Socket): void => {
  const getFoundryUserActors = (userId: string) => {
    const foundrySocket = getSocketFromRoom(io, socket, true);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USER_ACTORS,
        userId
      );
    }
    //TODO: Handle missing socket
  };

  const receiveFoundryUserActors = (userActors: UserActor[]) => {
    const iosSocket = getSocketFromRoom(io, socket, false);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_USER_ACTORS,
        JSON.stringify(userActors)
      );
    }
    //TODO: Handle missing socket
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_USER_ACTORS,
    getFoundryUserActors
  );
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_USER_ACTORS, receiveFoundryUserActors);
};

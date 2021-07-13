import { User } from "../interfaces/User";
import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../constants/events";
import { getSocketFromRoom } from "../utilities/SocketUtilities";

export const foundryUserListener = (io: Server, socket: Socket): void => {
  const getFoundryUsers = () => {
    const foundrySocket = getSocketFromRoom(io, socket, true);
    if (foundrySocket) {
      foundrySocket.emit(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USERS);
    }
    //TODO: Error if can't find socket
  };

  const receiveFoundryUsers = (users: User[]) => {
    const iosSocket = getSocketFromRoom(io, socket, false);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_USERS,
        JSON.stringify(users)
      );
    }
    //TODO: Error if can't find socket
  };

  socket.on(SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_USERS, getFoundryUsers);
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_USERS, receiveFoundryUsers);
};

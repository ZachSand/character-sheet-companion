import { User } from "../../interfaces/setup/User";
import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";

export const userListener = (io: Server, socket: Socket): void => {
  const getFoundryUsers = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USERS, socket.id);
    }
  };

  const receiveFoundryUsers = (users: User[], iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_USERS,
        JSON.stringify(users)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_USERS, getFoundryUsers);
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_USERS, receiveFoundryUsers);
};

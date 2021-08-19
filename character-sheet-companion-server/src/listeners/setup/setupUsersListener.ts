import { SetupUser } from "../../interfaces/setup/SetupUser";
import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";

export const setupUsersListener = (io: Server, socket: Socket): void => {
  const getFoundryUsers = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_USERS,
        socket.id
      );
    }
  };

  const receiveFoundryUsers = (users: SetupUser[], iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.SEND.SEND_FOUNDRY_USERS,
        JSON.stringify(users)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.SETUP.REQUEST_FOUNDRY_USERS, getFoundryUsers);
  socket.on(SOCKET_EVENTS.FOUNDRY.SETUP.SEND_USERS, receiveFoundryUsers);
};

import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";

export const setupUserAuthenticationListener = (
  io: Server,
  socket: Socket
): void => {
  const getUserAuthentication = (userId: string, password: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_USER_AUTH,
        userId,
        password,
        socket.id
      );
    }
  };

  const receiveUserAuthentication = (
    authResult: boolean,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.SEND.SEND_USER_AUTH,
        JSON.stringify(authResult)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.SETUP.REQUEST_FOUNDRY_USER_AUTH,
    getUserAuthentication
  );
  socket.on(SOCKET_EVENTS.FOUNDRY.SETUP.USER_AUTH, receiveUserAuthentication);
};

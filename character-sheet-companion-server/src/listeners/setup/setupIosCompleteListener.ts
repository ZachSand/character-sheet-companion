import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";
import { getFoundrySocketFromRoom } from "../../utilities/SocketUtilities";

export const setupIosCompleteListener = (io: Server, socket: Socket): void => {
  const receiveIosSetupComplete = (actorId: string, userId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.SEND.SEND_IOS_SETUP_COMPLETE,
        actorId,
        userId,
        socket.id
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.SETUP.SEND_IOS_SETUP_COMPLETE,
    receiveIosSetupComplete
  );
};

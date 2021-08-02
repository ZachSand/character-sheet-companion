import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { InitiativeRoll } from "../../interfaces/InitiativeRoll";

export const initiativeRollListener = (io: Server, socket: Socket): void => {
  const requestFoundryInitiativeRoll = (initiativeRoll: InitiativeRoll) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_INITIATIVE_ROLL,
        initiativeRoll,
        socket.id
      );
    }
  };

  const receiveFoundryInitiativeRoll = (
    initiativeRoll: InitiativeRoll,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_INITIATIVE_ROLL,
        JSON.stringify(initiativeRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_INITIATIVE_ROLL,
    requestFoundryInitiativeRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.SEND_INITIATIVE_ROLL,
    receiveFoundryInitiativeRoll
  );
};

import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { RollDeathSave } from "../../interfaces/rolls/RollDeathSave";

export const rollDeathSaveListener = (io: Server, socket: Socket): void => {
  const requestFoundryDeathSaveRoll = (deathSaveRoll: RollDeathSave) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_DEATH_SAVE_ROLL,
        deathSaveRoll,
        socket.id
      );
    }
  };

  const receiveFoundryDeathSaveRoll = (
    deathSaveRoll: RollDeathSave,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.SEND.SEND_FOUNDRY_DEATH_SAVE_ROLL,
        JSON.stringify(deathSaveRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ROLL.REQUEST_FOUNDRY_DEATH_SAVE_ROLL,
    requestFoundryDeathSaveRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ROLL.SEND_DEATH_SAVE_ROLL,
    receiveFoundryDeathSaveRoll
  );
};

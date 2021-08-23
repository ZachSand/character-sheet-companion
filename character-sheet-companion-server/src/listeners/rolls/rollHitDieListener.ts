import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { RollHitDie } from "../../interfaces/rolls/RollHitDie";

export const rollHitDieListener = (io: Server, socket: Socket): void => {
  const requestFoundryHitDieRoll = (rollHitDie: RollHitDie) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_HIT_DIE_ROLL,
        rollHitDie,
        socket.id
      );
    }
  };

  const receiveFoundryHitDieRoll = (
    rollHitDie: RollHitDie,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.SEND.SEND_FOUNDRY_ABILITY_ROLL,
        JSON.stringify(rollHitDie)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ROLL.REQUEST_FOUNDRY_HIT_DIE_ROLL,
    requestFoundryHitDieRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ROLL.SEND_HIT_DIE_ROLL,
    receiveFoundryHitDieRoll
  );
};

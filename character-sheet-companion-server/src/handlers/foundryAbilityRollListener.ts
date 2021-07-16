import { Server, Socket } from "socket.io";
import { AbilityRoll } from "../interfaces/AbilityRoll";
import { getSocketFromRoom } from "../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../constants/events";

export const foundryAbilityRollListener = (
  io: Server,
  socket: Socket
): void => {
  const requestFoundryAbilityRoll = (abilityRoll: AbilityRoll) => {
    const foundrySocket = getSocketFromRoom(io, socket, true);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ABILITY_ROLL,
        abilityRoll
      );
    }
  };

  const receiveFoundryAbilityRoll = (rollResult: number) => {
    const iosSocket = getSocketFromRoom(io, socket, false);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_ABILITY_ROLL,
        rollResult
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_ABILITY_ROLL,
    requestFoundryAbilityRoll
  );
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_ABILITY_ROLL, receiveFoundryAbilityRoll);
};

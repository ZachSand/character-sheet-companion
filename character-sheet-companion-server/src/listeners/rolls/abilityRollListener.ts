import { Server, Socket } from "socket.io";
import { AbilityRoll } from "../../interfaces/AbilityRoll";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";

export const abilityRollListener = (io: Server, socket: Socket): void => {
  const requestFoundryAbilityRoll = (abilityRoll: AbilityRoll) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ABILITY_ROLL,
        abilityRoll,
        socket.id
      );
    }
  };

  const receiveFoundryAbilityRoll = (
    abilityRoll: AbilityRoll,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_ABILITY_ROLL,
        JSON.stringify(abilityRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_ABILITY_ROLL,
    requestFoundryAbilityRoll
  );
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_ABILITY_ROLL, receiveFoundryAbilityRoll);
};

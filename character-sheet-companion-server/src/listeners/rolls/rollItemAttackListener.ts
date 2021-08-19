import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { RollItemAttack } from "../../interfaces/rolls/RollItemAttack";

export const rollItemAttackListener = (io: Server, socket: Socket): void => {
  const requestFoundryItemAttackRoll = (itemAttackRoll: RollItemAttack) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ITEM_ATTACK_ROLL,
        itemAttackRoll,
        socket.id
      );
    }
  };

  const receiveFoundryItemAttackRoll = (
    itemAttackRoll: RollItemAttack,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_ATTACK_ROLL,
        JSON.stringify(itemAttackRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ROLL.REQUEST_FOUNDRY_ITEM_ATTACK_ROLL,
    requestFoundryItemAttackRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ITEM_ATTACK_ROLL,
    receiveFoundryItemAttackRoll
  );
};

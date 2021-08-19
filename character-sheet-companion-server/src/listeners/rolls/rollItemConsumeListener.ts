import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { RollItemConsume } from "../../interfaces/rolls/RollItemConsume";

export const rollItemConsumeListener = (io: Server, socket: Socket): void => {
  const requestFoundryItemConsumeRoll = (itemConsumeRoll: RollItemConsume) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL,
        itemConsumeRoll,
        socket.id
      );
    }
  };

  const receiveFoundryItemConsumeRoll = (
    itemConsumeRoll: RollItemConsume,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_CONSUME_ROLL,
        JSON.stringify(itemConsumeRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ROLL.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL,
    requestFoundryItemConsumeRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ITEM_CONSUME_ROLL,
    receiveFoundryItemConsumeRoll
  );
};

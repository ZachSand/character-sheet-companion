import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ItemConsumeRoll } from "../../interfaces/rolls/ItemConsumeRoll";

export const itemConsumeRollListener = (io: Server, socket: Socket): void => {
  const requestFoundryItemConsumeRoll = (itemConsumeRoll: ItemConsumeRoll) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL,
        itemConsumeRoll,
        socket.id
      );
    }
  };

  const receiveFoundryItemConsumeRoll = (
    itemConsumeRoll: ItemConsumeRoll,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_ITEM_CONSUME_ROLL,
        JSON.stringify(itemConsumeRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL,
    requestFoundryItemConsumeRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.SEND_ITEM_CONSUME_ROLL,
    receiveFoundryItemConsumeRoll
  );
};

import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ItemToolRoll } from "../../interfaces/rolls/ItemToolRoll";

export const rollItemToolListener = (io: Server, socket: Socket): void => {
  const requestFoundryItemToolRoll = (itemToolRoll: ItemToolRoll) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ITEM_TOOL_ROLL,
        itemToolRoll,
        socket.id
      );
    }
  };

  const receiveFoundryItemToolRoll = (
    itemToolRoll: ItemToolRoll,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_TOOL_ROLL,
        JSON.stringify(itemToolRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ROLL.REQUEST_FOUNDRY_ITEM_TOOL_ROLL,
    requestFoundryItemToolRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ITEM_TOOL_ROLL,
    receiveFoundryItemToolRoll
  );
};

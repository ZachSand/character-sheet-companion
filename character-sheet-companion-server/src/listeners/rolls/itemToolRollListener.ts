import { Server, Socket } from "socket.io";
import {
  getIosSocketFromRoom,
  getFoundrySocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ItemToolRoll } from "../../interfaces/ItemToolRoll";

export const itemToolRollListener = (io: Server, socket: Socket): void => {
  const requestFoundryItemToolRoll = (itemToolRoll: ItemToolRoll) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ITEM_TOOL_ROLL,
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
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_ITEM_TOOL_ROLL,
        itemToolRoll
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_ITEM_TOOL_ROLL,
    requestFoundryItemToolRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.SEND_ITEM_TOOL_ROLL,
    receiveFoundryItemToolRoll
  );
};

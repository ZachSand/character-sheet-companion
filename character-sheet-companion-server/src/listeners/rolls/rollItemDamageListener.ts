import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ItemDamageRoll } from "../../interfaces/rolls/ItemDamageRoll";

export const rollItemDamageListener = (io: Server, socket: Socket): void => {
  const requestFoundryItemDamageRoll = (itemDamageRoll: ItemDamageRoll) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL,
        itemDamageRoll,
        socket.id
      );
    }
  };

  const receiveFoundryItemDamageRoll = (
    itemDamageRoll: ItemDamageRoll,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_DAMAGE_ROLL,
        JSON.stringify(itemDamageRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ROLL.REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL,
    requestFoundryItemDamageRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ITEM_DAMAGE_ROLL,
    receiveFoundryItemDamageRoll
  );
};
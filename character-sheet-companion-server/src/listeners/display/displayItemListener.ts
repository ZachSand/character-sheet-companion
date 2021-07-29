import { Server, Socket } from "socket.io";
import { getFoundrySocketFromRoom } from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ItemDisplay } from "../../interfaces/ItemDisplay";

export const displayItemListener = (io: Server, socket: Socket): void => {
  const requestFoundryDisplayItem = (itemDisplay: ItemDisplay) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_DISPLAY_ITEM,
        itemDisplay
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_DISPLAY_ITEM,
    requestFoundryDisplayItem
  );
};
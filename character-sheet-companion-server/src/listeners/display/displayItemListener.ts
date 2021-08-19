import { Server, Socket } from "socket.io";
import { getFoundrySocketFromRoom } from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { DisplayItem } from "../../interfaces/display/DisplayItem";

export const displayItemListener = (io: Server, socket: Socket): void => {
  const requestFoundryDisplayItem = (itemDisplay: DisplayItem) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.DISPLAY.REQUEST.REQUEST_FOUNDRY_DISPLAY_ITEM,
        itemDisplay
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.DISPLAY.REQUEST_FOUNDRY_DISPLAY_ITEM,
    requestFoundryDisplayItem
  );
};

import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { World } from "../../interfaces/setup/World";

export const worldDataListener = (io: Server, socket: Socket): void => {
  const getWorldData = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_WORLD_DATA,
        socket.id
      );
    }
  };

  const receiveWorldData = (world: World, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_WORLD_DATA,
        JSON.stringify(world)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_WORLD_DATA, getWorldData);
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_WORLD_DATA, receiveWorldData);
};

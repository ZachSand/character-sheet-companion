import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { SetupWorldData } from "../../interfaces/setup/SetupWorldData";

export const setupWorldDataListener = (io: Server, socket: Socket): void => {
  const getWorldData = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.REQUEST.REQUEST_FOUNDRY_WORLD_DATA,
        socket.id
      );
    }
  };

  const receiveWorldData = (world: SetupWorldData, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SETUP.SEND.SEND_FOUNDRY_WORLD_DATA,
        JSON.stringify(world)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.SETUP.REQUEST_FOUNDRY_WORLD_DATA, getWorldData);
  socket.on(SOCKET_EVENTS.FOUNDRY.SETUP.SEND_WORLD_DATA, receiveWorldData);
};

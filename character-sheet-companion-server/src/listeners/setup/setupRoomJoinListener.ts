import Logger from "../../loaders/logger";
import { Server, Socket } from "socket.io";
import { SOCKET_EVENTS } from "../../constants/events";

export const setupRoomJoinListener = (io: Server, socket: Socket): void => {
  const foundryJoin = (roomId: string) => {
    Logger.debug(`Foundry client connecting to room: ${roomId}`);
    socket.join(roomId);
    socket.data.foundry = true;
    socket.data.ios = false;
    socket.data.fccId = roomId;
    socket.emit(SOCKET_EVENTS.SERVER.SETUP.SEND.SEND_FOUNDRY_JOINED_ROOM);
  };

  const iosJoin = (roomId: string) => {
    const clients = io.sockets.adapter.rooms.get(roomId);
    if (clients) {
      const numClients = clients ? clients.size : 0;
      if (numClients == 0) {
        handleEmptyRoom();
      } else if (numClients == 1) {
        joinRoom();
      }
    } else {
      handleSocketRoomMissing();
    }

    function handleEmptyRoom() {
      Logger.error(
        `iOS client attempted to connect to room ${roomId} but there wasn't another socket in the room`
      );
      socket.emit(
        SOCKET_EVENTS.ERROR.SETUP.JOIN_ROOM,
        "No other sockets in room to join with"
      );
    }

    function joinRoom() {
      Logger.debug(`iOS client connecting to room: ${roomId}`);
      socket.join(roomId);
      socket.data.foundry = false;
      socket.data.ios = true;
      socket.data.fccId = roomId;
      socket.emit(SOCKET_EVENTS.SERVER.SETUP.SEND.SEND_IOS_JOINED_ROOM);
    }

    function handleSocketRoomMissing() {
      Logger.error(`Couldn't determine client count for room: ${roomId}`);
      socket.emit(
        SOCKET_EVENTS.ERROR.SETUP.JOIN_ROOM,
        `Couldn't determine client count for room: ${roomId}`
      );
    }
  };

  socket.on(SOCKET_EVENTS.FOUNDRY.SETUP.JOIN_ROOM, foundryJoin);
  socket.on(SOCKET_EVENTS.IOS.SETUP.JOIN_ROOM, iosJoin);
};
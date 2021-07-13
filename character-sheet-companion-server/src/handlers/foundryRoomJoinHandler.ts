import Logger from "../loaders/logger";
import { Socket, Server } from "socket.io";
import { SOCKET_EVENTS } from "../constants/events";

export const foundryRoomJoinListener = (io: Server, socket: Socket): void => {
  const foundryJoin = (roomId: string) => {
    Logger.debug(`Foundry client connecting to room: ${roomId}`);
    socket.join(roomId);
    socket.data.foundry = true;
    socket.data.ios = false;
    socket.data.cscId = roomId;
    socket.emit(SOCKET_EVENTS.FOUNDRY.JOINED_ROOM);
  };

  const iosJoin = (roomId: string) => {
    const clients = io.sockets.adapter.rooms.get(roomId);
    if (clients) {
      const numClients = clients ? clients.size : 0;
      if (numClients == 0) {
        handleEmptyRoom();
      } else if (numClients == 1) {
        joinRoom();
      } else {
        handleFullRoom();
      }
    } else {
      handleSocketRoomMissing();
    }

    function handleEmptyRoom() {
      Logger.error(
        `iOS client attempted to connect to room ${roomId} but there wasn't another socket in the room`
      );
      socket.emit(
        SOCKET_EVENTS.ERROR.JOIN_ROOM,
        "No other sockets in room to join with"
      );
    }

    function joinRoom() {
      Logger.debug(`iOS client connecting to room: ${roomId}`);
      socket.join(roomId);
      socket.data.foundry = false;
      socket.data.ios = true;
      socket.data.cscId = roomId;
      socket.emit(SOCKET_EVENTS.IOS.JOINED_ROOM);
    }

    function handleFullRoom() {
      Logger.error(`More than 1 socket already connected to room: ${roomId}`);
      socket.emit(
        SOCKET_EVENTS.ERROR.JOIN_ROOM,
        "More than one socket already joined in the room"
      );
    }

    function handleSocketRoomMissing() {
      Logger.error(`Couldn't determine client count for room: ${roomId}`);
      socket.emit(
        SOCKET_EVENTS.ERROR.JOIN_ROOM,
        `Couldn't determine client count for room: ${roomId}`
      );
    }
  };

  socket.on(SOCKET_EVENTS.FOUNDRY.JOIN_ROOM, foundryJoin);
  socket.on(SOCKET_EVENTS.IOS.JOIN_ROOM, iosJoin);
};

import { Server, Socket } from "socket.io";
import Logger from "../loaders/logger";

export function getFoundrySocketFromRoom(
  io: Server,
  socket: Socket
): Socket | null {
  const clients = io.sockets.adapter.rooms.get(socket.data.fccId);
  if (clients) {
    for (const clientId of clients) {
      const clientSocket: Socket = io.sockets.sockets.get(clientId);
      if (clientSocket.data.foundry) {
        return clientSocket;
      }
    }
  } else {
    Logger.error(
      `Error trying to find sockets in the Foundry Character Companion room: ${socket.data.fccId}`
    );
  }
  Logger.error(
    `Unable to find Foundry client for room Id ${socket.data.fccId}`
  );
  return null;
}

export function getIosSocketFromRoom(
  io: Server,
  socket: Socket,
  socketId: string
): Socket | null {
  const clients = io.sockets.adapter.rooms.get(socket.data.fccId);
  if (clients) {
    for (const clientId of clients) {
      const clientSocket: Socket = io.sockets.sockets.get(clientId);
      if (clientSocket.id === socketId && clientSocket.data.ios === true) {
        return clientSocket;
      }
    }
  } else {
    Logger.error(
      `Error trying to find sockets in the Foundry Character Companion room: ${socket.data.fccId}`
    );
  }
  Logger.error(`Unable to find IOS client for room Id ${socket.data.fccId}`);
  return null;
}

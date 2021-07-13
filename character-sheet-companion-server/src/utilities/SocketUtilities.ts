import { Server, Socket } from "socket.io";
import Logger from "../loaders/logger";

export function getSocketFromRoom(
  io: Server,
  socket: Socket,
  foundry: boolean
): Socket | null {
  const clients = io.sockets.adapter.rooms.get(socket.data.cscId);
  const numClients = clients ? clients.size : 0;
  if (clients && numClients == 2) {
    for (const clientId of clients) {
      const clientSocket: Socket = io.sockets.sockets.get(clientId);
      if (clientSocket) {
        if (foundry && clientSocket.data.foundry) {
          return clientSocket;
        } else if (!foundry && clientSocket.data.ios) {
          return clientSocket;
        }
      }
    }
  } else {
    Logger.error(
      `Error trying to getSocketFromRoom with numClients: ${numClients}`
    );
  }
  Logger.error(
    `Unable to find ${foundry ? "foundry" : "ios"} client for room Id ${
      socket.data.cscId
    }`
  );
  return null;
}

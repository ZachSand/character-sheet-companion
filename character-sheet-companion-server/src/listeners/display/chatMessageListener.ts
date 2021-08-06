import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ChatMessage } from "../../interfaces/display/ChatMessage";

export const chatMessageListener = (io: Server, socket: Socket): void => {
  const requestFoundryChatData = (userId: string, actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_CHAT_DATA,
        userId,
        actorId,
        socket.id
      );
    }
  };

  const receiveIosChatMessage = (
    userId: string,
    actorId: string,
    message: string
  ) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.SEND_IOS_CHAT_MESSAGE,
        userId,
        actorId,
        message
      );
    }
  };

  const receiveFoundryChatData = (
    chatMessages: ChatMessage[],
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_CHAT_DATA,
        JSON.stringify(chatMessages)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_CHAT_DATA,
    requestFoundryChatData
  );
  socket.on(SOCKET_EVENTS.IOS.SEND_FOUNDRY_CHAT_MESSAGE, receiveIosChatMessage);
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_CHAT_DATA, receiveFoundryChatData);
};

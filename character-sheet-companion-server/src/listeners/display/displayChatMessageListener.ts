import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { DisplayChatMessage } from "../../interfaces/display/DisplayChatMessage";

export const displayChatMessageListener = (
  io: Server,
  socket: Socket
): void => {
  const requestFoundryChatData = (userId: string, actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.DISPLAY.REQUEST.REQUEST_FOUNDRY_CHAT_DATA,
        userId,
        actorId,
        socket.id
      );
    }
  };

  const receiveChatMessage = (
    userId: string,
    actorId: string,
    message: string
  ) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.DISPLAY.SEND.SEND_FOUNDRY_CHAT_MESSAGE,
        userId,
        actorId,
        message
      );
    }
  };

  const receiveFoundryChatData = (
    chatMessages: DisplayChatMessage[],
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.DISPLAY.SEND.SEND_FOUNDRY_CHAT_DATA,
        JSON.stringify(chatMessages)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.DISPLAY.REQUEST_FOUNDRY_CHAT_DATA,
    requestFoundryChatData
  );
  socket.on(
    SOCKET_EVENTS.IOS.DISPLAY.SEND_FOUNDRY_CHAT_MESSAGE,
    receiveChatMessage
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.DISPLAY.SEND_CHAT_DATA,
    receiveFoundryChatData
  );
};

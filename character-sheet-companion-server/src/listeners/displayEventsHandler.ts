import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../utilities/socketUtilities";
import { ServerSocketRequestEvents } from "../events/socket/ServerSocketRequestEvents";
import { ServerSocketSendEvents } from "../events/socket/ServerSocketSendEvents";
import { IosSocketEvents } from "../events/socket/IosSocketEvents";
import { FoundrySocketEvents } from "../events/socket/FoundrySocketEvents";
import { DisplayChatMessage } from "../models/DisplayModels";

export const displayEventsHandler = (io: Server, socket: Socket): void => {
  const requestFoundryDisplayItem = (actorId: string, itemId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.DISPLAY.DISPLAY_ITEM,
        actorId,
        itemId
      );
    }
  };

  const requestFoundryChatData = (userId: string, actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.DISPLAY.CHAT_DATA,
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
        ServerSocketSendEvents.Instance.SERVER_EVENTS.DISPLAY.CHAT_MESSAGE,
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
        ServerSocketSendEvents.Instance.SERVER_EVENTS.DISPLAY.CHAT_DATA,
        JSON.stringify(chatMessages)
      );
    }
  };

  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.DISPLAY.DISPLAY_ITEM,
    requestFoundryDisplayItem
  );

  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.DISPLAY.CHAT_DATA,
    requestFoundryChatData
  );

  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.DISPLAY.CHAT_MESSAGE,
    receiveChatMessage
  );

  socket.on(
    FoundrySocketEvents.Instance.FOUNDRY_EVENTS.DISPLAY.CHAT_DATA,
    receiveFoundryChatData
  );
};

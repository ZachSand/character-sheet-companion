import { SOCKET_EVENTS } from "../../constants/events.js";
import { displayItemCard } from "./displayItemListener.js";
import {
  createAndEmitChatData,
  createChatMessage,
} from "./displayChatListener.js";

export function displayListenerWrapper(socket) {
  socket.on(
    SOCKET_EVENTS.SERVER.DISPLAY.REQUEST.REQUEST_FOUNDRY_DISPLAY_ITEM,
    (displayItem) => {
      displayItemCard(displayItem);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.DISPLAY.REQUEST.REQUEST_FOUNDRY_CHAT_DATA,
    (userId, actorId, iosSocketId) => {
      createAndEmitChatData(socket, userId, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.DISPLAY.SEND.SEND_FOUNDRY_CHAT_MESSAGE,
    (userId, actorId, message) => {
      createChatMessage(userId, actorId, message);
    }
  );
}

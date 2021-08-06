import { SOCKET_EVENTS } from "../../events/events.js";
import { displayItemCard } from "./displayItemListener.js";
import { createAndEmitChatData, createChatMessage } from "./chatListener.js";
import { createAndEmitSpellDialog } from "./spellDialogListener.js";

export function addDisplayListeners(socket) {
  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_DISPLAY_ITEM,
    (displayItem) => {
      displayItemCard(displayItem);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_CHAT_DATA,
    (userId, actorId, iosSocketId) => {
      createAndEmitChatData(socket, userId, actorId, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.SEND_IOS_CHAT_MESSAGE,
    (userId, actorId, message) => {
      createChatMessage(userId, actorId, message);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_SPELL_DIALOG,
    (actorId, spellId, iosSocketId) => {
      createAndEmitSpellDialog(socket, actorId, spellId, iosSocketId);
    }
  );
}

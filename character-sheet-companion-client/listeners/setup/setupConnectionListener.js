import { SOCKET_EVENTS } from "../../constants/events.js";
import { CHARACTER_SHEET_COMPANION_SETTING_KEY } from "../../utils/id-generator.js";

export function handleSocketConnect(socket) {
  socket.on("connect", () => {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.SETUP.JOIN_ROOM,
      game.settings.get(
        "character-sheet-companion",
        CHARACTER_SHEET_COMPANION_SETTING_KEY
      )
    );
  });
}

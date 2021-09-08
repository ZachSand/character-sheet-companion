import { CHARACTER_SHEET_COMPANION_SETTING_KEY } from "../../utils/id-generator.js";
import { FoundrySocketEvents } from "../../events/socket/FoundrySocketEvents.js";

export function handleSocketConnect(socket) {
  socket.on("connect", () => {
    socket.emit(
      FoundrySocketEvents.Instance().FOUNDRY_EVENTS.SETUP.JOIN_ROOM,
      game.settings.get(
        "character-sheet-companion",
        CHARACTER_SHEET_COMPANION_SETTING_KEY
      )
    );
  });
}

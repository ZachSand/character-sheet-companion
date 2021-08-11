import {
  CHARACTER_SHEET_COMPANION_SETTING_KEY,
  generateId,
} from "../utils/id-generator.js";
import { SOCKET_EVENTS } from "../events/events.js";
import { displayListenerWrapper } from "../listeners/display/displayListenerWrapper.js";
import { setupListenerWrapper } from "../listeners/setup/setupListenerWrapper.js";
import { rollListenerWrapper } from "../listeners/rolls/rollListenerWrapper.js";
import { actorListenerWrapper } from "../listeners/actor/actorListenerWrapper";

export class CharacterSheetCompanionSetup {
  static setup() {
    Hooks.on("init", () => {
      game.settings.register(
        "character-sheet-companion",
        CHARACTER_SHEET_COMPANION_SETTING_KEY,
        {
          name: "Character Sheet Companion ID",
          hint: "ID for app connectivity",
          scope: "client",
          config: true,
          type: String,
        }
      );

      const id = game.settings.get(
        "character-sheet-companion",
        CHARACTER_SHEET_COMPANION_SETTING_KEY
      );
      if (!id) {
        game.settings.set(
          "character-sheet-companion",
          CHARACTER_SHEET_COMPANION_SETTING_KEY,
          generateId()
        );
      }
    });

    Hooks.on("ready", () => {
      // Only allow a GM to connect -- Server will enforce only one GM connects to only have one Foundry client
      if (game.users.current.isGM) {
        const socket = io("http://localhost:3000", {
          autoConnect: false,
          reconnectionDelayMax: 15000, // Max of 15 seconds between connection attempts
          reconnectionAttempts: 10, // Max of 10 attempts of reconnection before stopping
          transports: ["websocket", "polling"], // Try websocket first, revert to polling if that fails
        });

        socket.on("connect", () => {
          socket.emit(
            SOCKET_EVENTS.FOUNDRY.JOIN_ROOM,
            game.settings.get(
              "character-sheet-companion",
              CHARACTER_SHEET_COMPANION_SETTING_KEY
            )
          );
        });

        displayListenerWrapper(socket);
        setupListenerWrapper(socket);
        rollListenerWrapper(socket);
        actorListenerWrapper(socket);

        socket.connect();

        // Select the token, get the image data, then unselect the token
        // Get the canvas (~168Kb)
        //game.canvas.app.renderer.plugins.extract.base64(game.canvas.app.stage, "image/jpeg", 0.15)

        // only activates after initial chat log rendering
        // Hooks.on("renderChatMessage", () => {
        //     createAndEmitChatData()
        // });
      }
    });
  }
}

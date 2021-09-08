import {
  CHARACTER_SHEET_COMPANION_SETTING_KEY,
  generateId,
} from "../utils/id-generator.js";
import { socketHandlerWrapper } from "../handlers/socket/socketHandlerWrapper.js";
import { shouldHandleHookEvent } from "../utils/commonUtilities.js";
import { handleUpdateActorHookEvent } from "../handlers/hooks/actorHookEventHandler.js";
import {
  handleCreateItemHookEvent,
  handleUpdateItemHookEvent,
} from "../handlers/hooks/itemHookEventHandler.js";
import { handleCreateActiveEffectHookEvent } from "../handlers/hooks/activeEffectHookEventHandler.js";

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

        socketHandlerWrapper(socket);
        socket.connect();

        Hooks.on("updateActor", async (entity, data, options, userId) => {
          if (shouldHandleHookEvent(entity.id)) {
            await handleUpdateActorHookEvent(
              socket,
              entity,
              data,
              options,
              userId
            );
          }
        });

        Hooks.on("updateItem", async (entity, data, options, userId) => {
          if (shouldHandleHookEvent(entity.parent.id)) {
            await handleUpdateItemHookEvent(
              socket,
              entity,
              data,
              options,
              userId
            );
          }
        });

        Hooks.on("createItem", (entity, options, userId) => {
          if (shouldHandleHookEvent(entity.parent.id)) {
            handleCreateItemHookEvent(socket, entity, options, userId);
          }
        });

        Hooks.on("createActiveEffect", (entity, options, userId) => {
          if (shouldHandleHookEvent(entity.parent.id)) {
            handleCreateActiveEffectHookEvent(socket, entity, options, userId);
          }
        });

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

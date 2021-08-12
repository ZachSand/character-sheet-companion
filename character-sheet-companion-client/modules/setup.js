import {
  CHARACTER_SHEET_COMPANION_SETTING_KEY,
  generateId,
} from "../utils/id-generator.js";
import { SOCKET_EVENTS } from "../events/events.js";
import { displayListenerWrapper } from "../listeners/display/displayListenerWrapper.js";
import { setupListenerWrapper } from "../listeners/setup/setupListenerWrapper.js";
import { rollListenerWrapper } from "../listeners/rolls/rollListenerWrapper.js";
import { actorListenerWrapper } from "../listeners/actor/actorListenerWrapper.js";

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
            SOCKET_EVENTS.FOUNDRY.SETUP.JOIN_ROOM,
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

        Hooks.on("updateActor", (entity, data, options, userId) => {
          // if it is a user connected to the character companion room -- need to save actors that are connected along with
          // their iosSocketId
          // easiest thing to do would be to regenerate the model and send it as an event rather than try to figure out what changed
          // though that could lead to changes that don't make a difference.. could cache the latest model that was sent and check if it is
          // different??
          console.log(data);

          // hp, attributes, senses, skills, biography,
          if (entity) {
            entity.data._id;
          }

          if (data) {
          }
        });

        Hooks.on("updateItem", (entity, data, options, userId) => {
          // spell updates, like spell level consumption
          // item updates, like potion consumption,
          // item description change, image change, etc.
          // Basically is the item was update, regenerate it into the model and send it as a socket event
          console.log(data);
        });

        Hooks.on("createItem", (entity, options, userId) => {
          // Send new item as an event
          console.log(entity);
          console.log(options);
          console.log(userId);
        });

        Hooks.on("createActiveEffect", (entity, options, userId) => {
          // active effects (fire, death, custom, etc.)
          console.log(entity);
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

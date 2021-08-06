import { generateId, CHARACTER_SHEET_COMPANION_SETTING_KEY } from "../utils/id-generator.js";
import { SOCKET_EVENTS } from "../events/events.js";
import {addDisplayListeners} from "../listeners/display/displayListenerWrapper.js";
import {addSetupListeners} from "../listeners/setup/setupListenerWrapper.js";
import {addRollListeners} from "../listeners/rolls/rollListenerWrapper.js";

export class CharacterSheetCompanionSetup {
    static setup() {

        Hooks.on("init", () => {
            game.settings.register("character-sheet-companion", "character-sheet-companion-uuid", {
                name: "Character Sheet Companion ID",
                hint: "ID for app connectivity",
                scope: "client",
                config: true,
                type: String
            });

            const id = game.settings.get("character-sheet-companion", "character-sheet-companion-uuid");
            if (!id) {
                game.settings.set("character-sheet-companion", "character-sheet-companion-uuid", generateId());
            }
        });

        Hooks.on("ready", () => {

            // Only allow a GM to connect -- Server will enforce only one GM connects to only have one Foundry client
            if(game.users.current.isGM) {
                const socket = io("http://localhost:3000", {
                    autoConnect: false,
                    reconnectionDelayMax: 15000,  // Max of 15 seconds between connection attempts
                    reconnectionAttempts: 10,      // Max of 10 attempts of reconnection before stopping
                    transports: ["websocket", "polling"], // Try websocket first, revert to polling if that fails
                });

                socket.on("connect", () => {
                    socket.emit(SOCKET_EVENTS.FOUNDRY.JOIN_ROOM, game.settings.get("character-sheet-companion", CHARACTER_SHEET_COMPANION_SETTING_KEY));
                });

                addDisplayListeners(socket);
                addSetupListeners(socket);
                addRollListeners(socket);

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
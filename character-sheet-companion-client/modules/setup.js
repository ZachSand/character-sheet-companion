import { generateId, CHARACTER_SHEET_COMPANION_SETTING_KEY } from "../utils/id-generator.js";
import { SOCKET_EVENTS } from "../events/events.js";
import { getAndEmitUsers } from "../listeners/userListener.js"
import { getAndEmitUserActors} from "../listeners/userActorListener.js";
import { getAndEmitActorData} from "../listeners/actorDataListener.js";
import { createAndEmitAbilityRoll } from "../listeners/abilityRollListener.js";
import { createAndEmitSkillRoll } from "../listeners/skillRollListener.js";
import { createAndEmitAttackRoll } from "../listeners/itemAttackRollListener.js";
import { displayItemCard } from "../listeners/displayItemListener.js";
import { getAndEmitWorldData } from "../listeners/worldDataListener.js";

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

                socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USERS, (iosSocketId) => {
                    getAndEmitUsers(socket, iosSocketId)
                });

                socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USER_ACTORS, (iosSocketId) => {
                    getAndEmitUserActors(socket, iosSocketId)
                });

                socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ACTOR_DATA, async (actorId, iosSocketId) => {
                    await getAndEmitActorData(socket, actorId, iosSocketId)
                });

                socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ABILITY_ROLL, (abilityRoll, iosSocketId) => {
                    createAndEmitAbilityRoll(socket, abilityRoll, iosSocketId)
                });

                socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_SKILL_ROLL, (skillRoll, iosSocketId) => {
                    createAndEmitSkillRoll(socket, skillRoll, iosSocketId)
                });

                socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ITEM_ATTACK_ROLL, (itemAttackRoll, iosSocketId) => {
                    createAndEmitAttackRoll(socket, itemAttackRoll, iosSocketId)
                });

                socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_DISPLAY_ITEM, (displayItem) => {
                    displayItemCard(socket, displayItem)
                });

                socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_WORLD_DATA, (iosSocketId) => {
                    getAndEmitWorldData(socket, iosSocketId)
                });

                socket.connect();

                // Select the token, get the image data, then unselect the token
                // Get the canvas (~168Kb)
                //game.canvas.app.renderer.plugins.extract.base64(game.canvas.app.stage, "image/jpeg", 0.15)
            }
        });
    }
}
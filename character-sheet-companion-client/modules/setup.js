import { generateId, CHARACTER_SHEET_COMPANION_SETTING_KEY } from "../utils/id-generator.js";
import { SOCKET_EVENTS } from "../events/events.js";
import { sendUsers } from "../handlers/user-handler.js"
import { sendUserActors} from "../handlers/user-actor-handler.js";
import { sendActorData} from "../handlers/actor-handler.js";
import { sendAbilityRoll } from "../handlers/ability-roll-handler.js";
import { sendSkillRoll } from "../handlers/skill-roll-handler.js";

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
            const socket = io.connect("http://localhost:3000");
            socket.on("connect", () => {
                socket.emit(SOCKET_EVENTS.FOUNDRY.JOIN_ROOM, game.settings.get("character-sheet-companion", CHARACTER_SHEET_COMPANION_SETTING_KEY));
            });
            socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USERS, () => sendUsers(socket));
            socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USER_ACTORS, (userId) => sendUserActors(socket, userId));
            socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ACTOR_DATA, (actorId) => sendActorData(socket, actorId));
            socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ABILITY_ROLL, (abilityRoll) => sendAbilityRoll(socket, abilityRoll));
            socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_SKILL_ROLL, (skillRoll) => sendSkillRoll(socket, skillRoll));

            // Select the token, get the image data, then unselect the token
            // Get the canvas (~168Kb)
            //game.canvas.app.renderer.plugins.extract.base64(game.canvas.app.stage, "image/jpeg", 0.15)

        });
    }
}
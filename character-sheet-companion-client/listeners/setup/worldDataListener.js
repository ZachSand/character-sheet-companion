import { SOCKET_EVENTS } from "../../events/events.js";

export function getAndEmitWorldData(socket, iosSocketId) {
    let description = "No description";
    if(game.world.data.description) {
        description = jQuery("<p>" + game.world.data.description + "</p>").text()
    }
    socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_WORLD_DATA, {
        title: game.world.data.title,
        version: game.world.data.version,
        description: description,
        coreVersion: game.world.data.coreVersion,
        system: game.world.data.system
    }, iosSocketId);
}
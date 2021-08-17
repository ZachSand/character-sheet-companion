import { SOCKET_EVENTS } from "../../constants/events.js";
import { removeHtml } from "../../utils/commonUtilities.js";

export function getAndEmitWorldData(socket, iosSocketId) {
  socket.emit(
    SOCKET_EVENTS.FOUNDRY.SETUP.SEND_WORLD_DATA,
    {
      id: game.world.id,
      title: game.world.data.title,
      version: game.world.data.version,
      description: game.world.data.description
        ? removeHtml(game.world.data.description)
        : "No description",
      coreVersion: game.world.data.coreVersion,
      system: game.world.data.system,
    },
    iosSocketId
  );
}

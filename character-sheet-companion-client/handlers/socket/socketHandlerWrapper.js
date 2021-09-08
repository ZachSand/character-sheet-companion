import { handleSetupEvents } from "./setupEventsHandler.js";
import { handleDisplayEvents } from "./displayEventsHandler.js";
import { handleRollEvents } from "./rollEventsHandler.js";
import { handleActorEvents } from "./actorEventHandlers.js";
import { handleActorChangeEvents } from "./actorChangeEventsHandler.js";
import { handleSocketConnect } from "./setupConnectionHandler";

export function socketHandlerWrapper(socket) {
  handleSocketConnect(socket);

  handleSetupEvents(socket);
  handleDisplayEvents(socket);
  handleRollEvents(socket);
  handleActorEvents(socket);
  handleActorChangeEvents(socket);
}

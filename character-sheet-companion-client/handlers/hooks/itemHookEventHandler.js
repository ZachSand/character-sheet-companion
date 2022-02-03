import { IOS_DATA_MAP } from "../socket/setupEventsHandler.js";
import { handleActorEvent } from "../socket/actorEventHandlers.js";
import { CORE_EVENTS } from "../../events/coreEvents.js";

export function handleCreateItemHookEvent(socket, entity, options, userId) {}

export async function handleUpdateItemHookEvent(
  socket,
  entity,
  data,
  options,
  userId
) {
  if (data) {
    console.log("class");
    let itemData = data.data;
    let itemId = entity.id;
    let actorId = entity.parent.id;
    let iosSocketId = IOS_DATA_MAP.get(actorId).iosSocketId;

    if (itemData.hitDiceUsed) {
      await handleActorEvent(CORE_EVENTS.CLASSES, socket, actorId, iosSocketId);
    }
  }
}

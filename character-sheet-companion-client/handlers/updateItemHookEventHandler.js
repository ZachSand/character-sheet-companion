import { IOS_DATA_MAP } from "../listeners/setup/setupIosCompleteListener.js";
import { createAndEmitActorClasses } from "../listeners/actor/actorClassesListener.js";

export function handleUpdateItemHookEvent(
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
      createAndEmitActorClasses(socket, actorId, iosSocketId);
    }
  }
}

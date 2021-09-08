import { handleActorEvent } from "../socket/actorEventHandlers";
import { CORE_EVENTS } from "../../events/coreEvents.js";
import { IOS_DATA_MAP } from "../socket/setupEventsHandler.js";

export async function handleUpdateActorHookEvent(
  socket,
  entity,
  data,
  options,
  userId
) {
  if (data) {
    let actorData = data.data;
    let actorId = entity.data._id;
    let iosSocketId = IOS_DATA_MAP.get(actorId).iosSocketId;

    // actor data
    if (data.data) {
      Object.keys(actorData).map(async (key) => {
        switch (key.toLowerCase()) {
          case "skills":
            await handleActorEvent(
              CORE_EVENTS.SKILLS,
              socket,
              actorId,
              iosSocketId
            );
            break;
          case "abilities":
            await handleActorEvent(
              CORE_EVENTS.ABILITIES,
              socket,
              actorId,
              iosSocketId
            );
            break;
          case "attributes":
            await handleActorEvent(
              CORE_EVENTS.ATTRIBUTES,
              socket,
              actorId,
              iosSocketId
            );
            break;
          case "details":
            await handleActorEvent(
              CORE_EVENTS.DETAILS,
              socket,
              actorId,
              iosSocketId
            );
            break;
          case "currency":
            await handleActorEvent(
              CORE_EVENTS.CURRENCY,
              socket,
              actorId,
              iosSocketId
            );
            break;
          case "spells":
            await handleActorEvent(
              CORE_EVENTS.SPELL_SLOTS,
              socket,
              actorId,
              iosSocketId
            );
            break;
          case "classes":
            await handleActorEvent(
              CORE_EVENTS.CLASSES,
              socket,
              actorId,
              iosSocketId
            );
            break;
          case "traits":
            await handleActorEvent(
              CORE_EVENTS.TRAITS,
              socket,
              actorId,
              iosSocketId
            );
            break;
          default:
          //TODO: Log that something wasn't handled?
        }
      });
    } else {
      if (data.name || data.img || data._id) {
        await handleActorEvent(
          CORE_EVENTS.BASE_DATA,
          socket,
          actorId,
          iosSocketId
        );
      }
    }
  }
}

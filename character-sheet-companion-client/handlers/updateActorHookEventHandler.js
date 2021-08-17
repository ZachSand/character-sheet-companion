import { createAndEmitActorOverview } from "../listeners/actor/actorOverviewListener.js";
import { IOS_DATA_MAP } from "../listeners/setup/setupIosCompleteListener.js";
import { createAndEmitActorAbilities } from "../listeners/actor/actorAbilityListener.js";
import { createAndEmitSkills } from "../listeners/actor/actorSkillListener.js";
import { createAndEmitActorBiography } from "../listeners/actor/actorBiographyListener.js";
import { createAndEmitCurrency } from "../listeners/actor/actorCurrencyListener.js";
import { createAndEmitSpellSlots } from "../listeners/actor/actorSpellSlotListener.js";

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
      await Promise.all(
        Object.keys(actorData).map(async (key) => {
          switch (key) {
            case "skills":
              createAndEmitSkills(socket, actorId, iosSocketId);
              break;
            case "abilities":
              createAndEmitActorAbilities(socket, actorId, iosSocketId);
              break;
            case "attributes":
              //TODO - avoid sending actor image if it wasn't updated
              await createAndEmitActorOverview(socket, actorId, iosSocketId);
              break;
            case "details":
              createAndEmitActorBiography(socket, actorId, iosSocketId);
              break;
            case "currency":
              createAndEmitCurrency(socket, actorId, iosSocketId);
              break;
            case "spells":
              createAndEmitSpellSlots(socket, actorId, iosSocketId);
              break;
            default:
            //??
          }
        })
      );
    } else {
      if (data.name || data.img) {
        await createAndEmitActorOverview(socket, actorId, iosSocketId);
      }
    }
  }
}

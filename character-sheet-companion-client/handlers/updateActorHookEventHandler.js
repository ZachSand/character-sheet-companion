import { createAndEmitActorAttributes } from "../listeners/actor/actorAttributesListener.js";
import { IOS_DATA_MAP } from "../listeners/setup/setupIosCompleteListener.js";
import { createAndEmitActorAbilities } from "../listeners/actor/actorAbilityListener.js";
import { createAndEmitActorSkills } from "../listeners/actor/actorSkillListener.js";
import { createAndEmitActorDetails } from "../listeners/actor/actorDetailsListener.js";
import { createAndEmitActorCurrency } from "../listeners/actor/actorCurrencyListener.js";
import { createAndEmitActorSpellSlots } from "../listeners/actor/actorSpellSlotListener.js";
import { createAndEmitActorBaseData } from "../listeners/actor/actorBaseDataListener.js";
import { createAndEmitActorClasses } from "../listeners/actor/actorClassesListener.js";
import { createAndEmitActorTraits } from "../listeners/actor/actorTraitsListener.js";

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
      Object.keys(actorData).map((key) => {
        switch (key) {
          case "skills":
            createAndEmitActorSkills(socket, actorId, iosSocketId);
            break;
          case "abilities":
            createAndEmitActorAbilities(socket, actorId, iosSocketId);
            break;
          case "attributes":
            createAndEmitActorAttributes(socket, actorId, iosSocketId);
            break;
          case "details":
            createAndEmitActorDetails(socket, actorId, iosSocketId);
            break;
          case "currency":
            createAndEmitActorCurrency(socket, actorId, iosSocketId);
            break;
          case "spells":
            createAndEmitActorSpellSlots(socket, actorId, iosSocketId);
            break;
          case "classes":
            createAndEmitActorClasses(socket, actorId, iosSocketId);
            break;
          case "traits":
            createAndEmitActorTraits(socket, actorId, iosSocketId);
            break;
          default:
          //??
        }
      });
    } else {
      if (data.name || data.img || data._id) {
        await createAndEmitActorBaseData(socket, actorId, iosSocketId);
      }
    }
  }
}

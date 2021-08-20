import { SOCKET_EVENTS } from "../../constants/events.js";
import { getActorOrEmitError } from "../../utils/commonUtilities.js";

export function createAndEmitActorTraits(socket, actorId, iosSocketId) {
  let actor = getActorOrEmitError(socket, actorId, iosSocketId);
  if (actor) {
    let traits = actor.data.data.traits;
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_TRAITS,
      {
        languages: traits.languages.value,
        size: CONFIG.DND5E.actorSizes[traits.size],
        toolProficiencies: traits.toolProf.value,
        weaponProficiencies: traits.weaponProf.value?.map(
          (weaponProficiency) =>
            CONFIG.DND5E.weaponProficiencies[weaponProficiency]
        ),
        armorProficiencies: traits.armorProf.value?.map(
          (armorProficiency) =>
            CONFIG.DND5E.armorProficiencies[armorProficiency]
        ),
        damageImmunities: traits.di.value || [],
        damageResistances: traits.dr.value || [],
        damageVulnerabilities: traits.dv.value || [],
        conditionImmunities: traits.ci.value || [],
        senses: {
          blindsight: traits.senses.blindsight || 0,
          darkvision: traits.senses.darkvision || 0,
          special: traits.senses.special || "",
          tremorsense: traits.senses.tremorsense || 0,
          truesight: traits.senses.truesight || 0,
          units: traits.senses.units || "ft",
        },
      },
      iosSocketId
    );
  }
}

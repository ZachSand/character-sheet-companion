import { SOCKET_EVENTS } from "../../constants/events.js";
import { getActorOrEmitError } from "../../utils/commonUtilities.js";

export function createAndEmitActorAbilities(socket, actorId, iosSocketId) {
  let actor = getActorOrEmitError(socket, actorId, iosSocketId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_ABILITIES,
      {
        abilities: Object.entries(actor.data.data.abilities).map(
          (abilityEntry) => {
            let abilityId = abilityEntry[0];
            let ability = abilityEntry[1];
            return {
              id: abilityEntry[0],
              name: CONFIG.DND5E.abilities[abilityId],
              bonusModifier: ability.mod,
              totalScore: ability.value,
              bonusSaveModifier: ability.save,
            };
          }
        ),
      },
      iosSocketId
    );
  }
}

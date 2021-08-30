import { SOCKET_EVENTS } from "../../constants/events.js";
import { getActorOrEmitError } from "../../utils/commonUtilities.js";

export function createAndEmitActorSkills(socket, actorId, iosSocketId) {
  let actor = getActorOrEmitError(socket, actorId, iosSocketId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_SKILLS,
      {
        skills: Object.entries(actor.data.data.skills).map((skillEntry) => {
          let skillId = skillEntry[0];
          let skill = skillEntry[1];
          return {
            id: skillId,
            name: skill.label,
            proficient: skill.prof > 0,
            abilityModifier: skill.ability,
            bonusModifier: skill.total,
            passiveValue: skill.passive,
          };
        }),
      },
      iosSocketId
    );
  }
}

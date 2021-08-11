import { SOCKET_EVENTS } from "../../events/events.js";

export function createAndEmitActorAbilities(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_ABILITIES,
      Object.entries(actor.data.data.abilities).map((abilityEntry) => {
        let abilityId = abilityEntry[0];
        let ability = abilityEntry[1];
        return {
          id: abilityEntry[0],
          name: CONFIG.DND5E.abilities[abilityId],
          bonusModifier: ability.mod,
          totalScore: ability.value,
          bonusSaveModifier: ability.save,
        };
      }),
      iosSocketId
    );
  }
}

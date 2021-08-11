import { SOCKET_EVENTS } from "../../events/events.js";

export function createAndEmitInitiativeRoll(
  socket,
  initiativeRoll,
  iosSocketId
) {
  let initiativeRollObj = JSON.parse(initiativeRoll);
  let actor = game.actors.get(initiativeRollObj.actorId);

  if (actor && initiativeRollObj) {
    actor.rollInitiative().then((rollResult) => {
      initiativeRollObj.result = rollResult._total;
      socket.emit(
        SOCKET_EVENTS.FOUNDRY.ROLL.SEND_INITIATIVE_ROLL,
        initiativeRollObj,
        iosSocketId
      );
    });
  }
}

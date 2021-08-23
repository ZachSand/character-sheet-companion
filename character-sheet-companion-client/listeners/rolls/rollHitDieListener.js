import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitHitDieRoll(socket, hitDieRoll, iosSocketId) {
  if (hitDieRoll) {
    let hitDieRollObj = JSON.parse(hitDieRoll);
    let actor = game.actors.get(hitDieRollObj.actorId);

    if (hitDieRollObj && actor) {
      actor
        .rollHitDie(hitDieRollObj.hitDie, { dialog: false })
        .then((rollResult) => {
          hitDieRollObj.result += rollResult.total;
          socket.emit(
            SOCKET_EVENTS.FOUNDRY.ROLL.SEND_HIT_DIE_ROLL,
            hitDieRollObj,
            iosSocketId
          );
        });
    }
  }
}

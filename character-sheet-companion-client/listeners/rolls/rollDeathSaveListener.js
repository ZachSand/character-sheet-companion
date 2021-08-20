import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitDeathSaveRoll(socket, deathSaveRoll, iosSocketId) {
  if (deathSaveRoll) {
    let deathSaveRollObj = JSON.parse(deathSaveRoll);
    let actor = game.actors.get(deathSaveRollObj.actorId);

    if (deathSaveRollObj && actor) {
      actor
        .rollDeathSave({
          advantage: deathSaveRollObj.advantage,
          disadvantage: deathSaveRollObj.disadvantage,
          fastForward: true,
        })
        .then((rollResult) => {
          deathSaveRollObj.result = rollResult._total;
          socket.emit(
            SOCKET_EVENTS.FOUNDRY.ROLL.SEND_DEATH_SAVE_ROLL,
            deathSaveRollObj,
            iosSocketId
          );
        });
    }
  }
}

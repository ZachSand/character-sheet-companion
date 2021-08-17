import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitAbilityRoll(socket, abilityRoll, iosSocketId) {
  if (abilityRoll) {
    let abilityRollObj = JSON.parse(abilityRoll);
    let actor = game.actors.get(abilityRollObj.actorId);

    if (abilityRollObj && actor) {
      let rollOptions = {
        advantage: abilityRollObj.advantage,
        disadvantage: abilityRollObj.disadvantage,
        fastForward: true,
      };

      if (abilityRollObj.isSave) {
        actor
          .rollAbilitySave(abilityRollObj.ability, rollOptions)
          .then((roll) => {
            abilityRollObj.result = roll._total;
            socket.emit(
              SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ABILITY_ROLL,
              abilityRollObj,
              iosSocketId
            );
          });
      } else {
        actor
          .rollAbilityTest(abilityRollObj.ability, rollOptions)
          .then((roll) => {
            abilityRollObj.result = roll._total;
            socket.emit(
              SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ABILITY_ROLL,
              abilityRollObj,
              iosSocketId
            );
          });
      }
    }
  }
}

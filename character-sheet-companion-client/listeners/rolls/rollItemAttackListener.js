import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitAttackRoll(socket, itemAttackRoll, iosSocketId) {
  if (itemAttackRoll) {
    let itemAttackRollObj = JSON.parse(itemAttackRoll);
    let actor = game.actors.get(itemAttackRollObj.actorId);
    let item = actor.items.get(itemAttackRollObj.itemId);

    if (itemAttackRollObj && actor && item) {
      item
        .rollAttack({
          advantage: itemAttackRollObj.advantage,
          disadvantage: itemAttackRollObj.disadvantage,
          fastForward: true,
        })
        .then((rollResult) => {
          itemAttackRollObj.result = rollResult._total;
          socket.emit(
            SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ITEM_ATTACK_ROLL,
            itemAttackRollObj,
            iosSocketId
          );
        });
    }
  }
}

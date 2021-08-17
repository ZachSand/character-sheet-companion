import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitItemDamageRoll(
  socket,
  itemDamageRoll,
  iosSocketId
) {
  if (itemDamageRoll) {
    let itemDamageRollObj = JSON.parse(itemDamageRoll);
    let actor = game.actors.get(itemDamageRollObj.actorId);
    let item = actor.items.get(itemDamageRollObj.itemId);

    if (itemDamageRollObj && actor && item) {
      item
        .rollDamage({
          critical: itemDamageRollObj.critical,
          versatile: itemDamageRollObj.versatile,
          options: {
            fastForward: true,
          },
        })
        .then((rollResult) => {
          itemDamageRollObj.result = rollResult._total;
          socket.emit(
            SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ITEM_DAMAGE_ROLL,
            itemDamageRollObj,
            iosSocketId
          );
        });
    }
  }
}

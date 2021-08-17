import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitItemToolRoll(socket, itemToolRoll, iosSocketId) {
  if (itemToolRoll) {
    let itemToolRollObj = JSON.parse(itemToolRoll);
    let actor = game.actors.get(itemToolRollObj.actorId);
    let item = actor.items.get(itemToolRollObj.itemId);

    if (itemToolRollObj && actor && item) {
      item
        .rollToolCheck({
          advantage: itemToolRollObj.advantage,
          disadvantage: itemToolRollObj.disadvantage,
          fastForward: true,
        })
        .then((rollResult) => {
          itemToolRollObj.result = rollResult._total;
          socket.emit(
            SOCKET_EVENTS.FOUNDRY.ROLL.SEND_ITEM_TOOL_ROLL,
            itemToolRollObj,
            iosSocketId
          );
        });
    }
  }
}

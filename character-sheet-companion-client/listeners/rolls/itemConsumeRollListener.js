import { SOCKET_EVENTS } from "../../events/events.js";

export function createAndEmitItemConsumeRoll(
  socket,
  itemConsumeRoll,
  iosSocketId
) {
  if (itemConsumeRoll) {
    let itemConsumeRollObj = JSON.parse(itemConsumeRoll);
    let actor = game.actors.get(itemConsumeRollObj.actorId);
    let item = actor.items.get(itemConsumeRollObj.itemId);

    if (itemConsumeRollObj && actor && item) {
      if (itemConsumeRollObj.consume) {
        // Consumes usage of item if it has any left
        item.roll({ configureDialog: false, chatMessage: false });
      }

      let rollOptions = {
        critical: false,
        versatile: false,
        options: {
          fastForward: true,
        },
      };

      item.rollDamage(rollOptions).then((rollResult) => {
        itemConsumeRollObj.result = rollResult._total;
        socket.emit(
          SOCKET_EVENTS.FOUNDRY.SEND_ITEM_CONSUME_ROLL,
          itemConsumeRollObj,
          iosSocketId
        );
      });
    }
  }
}

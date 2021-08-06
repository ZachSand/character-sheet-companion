import { SOCKET_EVENTS } from "../../events/events.js";

export function createAndEmitItemToolRoll(socket, itemToolRoll, iosSocketId) {
    if(itemToolRoll) {
        let itemToolRollObj = JSON.parse(itemToolRoll);
        let actor = game.actors.get(itemToolRollObj.actorId);
        let item = actor.items.get(itemToolRollObj.itemId);

        if (itemToolRollObj && actor && item) {

            let rollOptions = {
                "advantage": itemToolRollObj.advantage,
                "disadvantage": itemToolRollObj.disadvantage,
                "fastForward": true
            };

            item.rollToolCheck(rollOptions)
                .then(rollResult => {
                    itemToolRollObj.result = rollResult._total;
                    socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_ITEM_CONSUME_ROLL, itemToolRollObj, iosSocketId);
                });
        }
    }
}
import { SOCKET_EVENTS } from "../events/events.js";

export function createAndEmitItemDamageRoll(socket, itemDamageRoll, iosSocketId) {
    if(itemDamageRoll) {
        let itemDamageRollObj = JSON.parse(itemDamageRoll);
        let actor = game.actors.get(itemDamageRollObj.actorId);
        let item = actor.items.get(itemDamageRollObj.itemId);

        if (itemDamageRollObj && actor && item) {

            let rollOptions = {
                "critical": itemDamageRollObj.critical,
                "versatile": itemDamageRollObj.versatile,
                "options": {
                    "fastForward": true
                }
            }

            item.rollDamage(rollOptions)
                .then(rollResult => {
                    itemDamageRollObj.result = rollResult._total;
                    socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_ITEM_DAMAGE_ROLL, itemDamageRollObj, iosSocketId);
                });
        }
    }
}
import { SOCKET_EVENTS } from "../../events/events.js";

export function createAndEmitAttackRoll(socket, itemAttackRoll, iosSocketId) {
    if(itemAttackRoll) {
        let itemAttackRollObj = JSON.parse(itemAttackRoll);
        let actor = game.actors.get(itemAttackRollObj.actorId);
        let item = actor.items.get(itemAttackRollObj.itemId);

        if (itemAttackRollObj && actor && item) {

            let rollOptions = {
                "advantage": itemAttackRollObj.advantage,
                "disadvantage": itemAttackRollObj.disadvantage,
                "fastForward": true
            };

            item.rollAttack(rollOptions)
            .then(rollResult => {
                itemAttackRollObj.result = rollResult._total;
                socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_ITEM_ATTACK_ROLL, itemAttackRollObj, iosSocketId);
            });
        }
    }
}
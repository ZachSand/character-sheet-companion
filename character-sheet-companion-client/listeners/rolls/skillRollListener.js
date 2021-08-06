import { SOCKET_EVENTS } from "../../events/events.js";

export function createAndEmitSkillRoll(socket, skillRoll, iosSocketId) {
    if(skillRoll) {
        let skillRollObj = JSON.parse(skillRoll);
        let actor = game.actors.get(skillRollObj.actorId);

        if (skillRollObj && actor) {

            let rollOptions = {
                "advantage": skillRollObj.advantage,
                "disadvantage": skillRollObj.disadvantage,
                "fastForward": true
            };

            actor.rollSkill(skillRollObj.skill, rollOptions)
            .then(roll => {
                skillRollObj.result = roll._total;
                socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_SKILL_ROLL, skillRollObj, iosSocketId);
            });
        }
    }
}
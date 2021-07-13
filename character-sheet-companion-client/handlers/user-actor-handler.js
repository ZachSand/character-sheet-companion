import { SOCKET_EVENTS } from "../events/events.js";

export function sendUserActors(socket, userId) {
    let user = game.users.get(userId);
    if(user) {
        // Don't get NPC or vehicles
        let userActors = game.actors.filter(actor => actor.type === "character");
        if (!user.isGM) {
            userActors.filter(actor => actor.getUserLevel(user) === CONST.OWNER);
        }
        let userActorData = [];
        game.actors.forEach(actor => {
            let userActor = {
                'actorId': actor.data._id,
                'name': actor.data.name
            }
            userActorData.push(userActor);
        });
        socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_USER_ACTORS, userActorData);
    }
}
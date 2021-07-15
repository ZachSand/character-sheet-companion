import { SOCKET_EVENTS } from "../events/events.js";

export function sendUserActors(socket, userId) {
    let user = game.users.get(userId);
    if(user) {
        // Don't get NPC or vehicles
        let userActors = game.actors.filter(actor => actor.type === "character");

        if (!user.isGM) {
            // Only get the actors the user has owns
            userActors = userActors.filter(actor => actor.getUserLevel(user) === 3);
        }
        let userActorData = [];
        userActors.forEach(actor => {
            let userActor = {
                'actorId': actor.data._id,
                'name': actor.data.name
            }
            userActorData.push(userActor);
        });
        socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_USER_ACTORS, userActorData);
    }
}
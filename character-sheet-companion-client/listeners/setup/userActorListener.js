import { SOCKET_EVENTS } from "../../events/events.js";

export function getAndEmitUserActors(socket, iosSocketId) {
    let userActors = game.actors.filter(actor => actor.type === "character");
    let userActorData = [];
    userActors.forEach(actor => {
        let userActor = {
            'actorId': actor.data._id,
            'name': actor.data.name
        }
        userActorData.push(userActor);
    });
    socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_USER_ACTORS, userActorData, iosSocketId);
}
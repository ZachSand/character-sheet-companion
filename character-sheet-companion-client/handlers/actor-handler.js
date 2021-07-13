import { SOCKET_EVENTS } from "../events/events.js";

export function sendActorData(socket, actorId) {
    socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_ACTOR_DATA, game.actors.get(actorId));
}
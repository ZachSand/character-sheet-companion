import {SOCKET_EVENTS} from "../../events/events.js";
import {getAndEmitUsers} from "./userListener.js";
import {getAndEmitUserActors} from "./userActorListener.js";
import {getAndEmitActorData} from "./actorDataListener.js";
import {getAndEmitWorldData} from "./worldDataListener.js";

export function addSetupListeners(socket) {
    socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USERS, (iosSocketId) => {
        getAndEmitUsers(socket, iosSocketId)
    });

    socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_USER_ACTORS, (iosSocketId) => {
        getAndEmitUserActors(socket, iosSocketId)
    });

    socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ACTOR_DATA, async (actorId, iosSocketId) => {
        await getAndEmitActorData(socket, actorId, iosSocketId)
    });

    socket.on(SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_WORLD_DATA, (iosSocketId) => {
        getAndEmitWorldData(socket, iosSocketId)
    });
}
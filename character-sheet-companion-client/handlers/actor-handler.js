import {SOCKET_EVENTS} from "../events/events.js";

export function sendActorData(socket, actorId) {
    let actor5eData = getSanitizedActorData();

    if(actor5eData) {
        socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_ACTOR_DATA, actor5eData)
    }

    function getSanitizedActorData() {
        let actor5eData = getCustom5eActorData();
        if (actor5eData.hasOwnProperty("actor")) {
            sanitizeActorData(actor5eData);
            if (actor5eData.actor.hasOwnProperty("actorItems")) {
                sanitizeActorItems(actor5eData);
            }
        }
        return actor5eData;
    }

    // System5e puts Actor5E data on ActorData's data field
    // For some reason there is a single item field, so just make a deep copy and remove it
    // Could be done on the server with a replacer for stringify
    function getCustom5eActorData() {
        let actor = game.actors.get(actorId)
        if(actor) {
            return JSON.parse(JSON.stringify({
                "actor": {
                    "name": actor.data.name,
                    "id": actor.data._id,
                    "actorData": actor.data.data,
                    "actorItems": actor.data.items
                }
            }));
        }
    }

    function sanitizeActorData(actor5eData) {
        if (actor5eData.actor.hasOwnProperty("actorData")) {

            // For some reason there is a single item on in the actor data
            if (actor5eData.actor.actorData.hasOwnProperty("item")) {
                delete actor5eData.actor.actorData.item;
            }

            if (actor5eData.actor.actorData.hasOwnProperty("classes")) {
                let classes = [];
                for (let actorClass in actor5eData.actor.actorData.classes) {
                    if (actor5eData.actor.actorData.classes.hasOwnProperty(actorClass)) {
                        let actorData = actor5eData.actor.actorData.classes[actorClass];
                        actorData["name"] = actorClass;
                        classes.push(actorData);
                    }
                }
                actor5eData.actor.actorData.classes = classes;
            }

            if(actor5eData.actor.actorData.hasOwnProperty("details") &&
                actor5eData.actor.actorData.details.hasOwnProperty("biography") &&
                actor5eData.actor.actorData.details.biography.hasOwnProperty("public")) {
                    delete actor5eData.actor.actorData.details.biography.public;
            }
        }
    }

    function sanitizeActorItems(actor5eData) {
        for (let index in actor5eData.actor.actorItems) {
            if (actor5eData.actor.actorItems.hasOwnProperty(index)) {
                let item = actor5eData.actor.actorItems[index];
                if (item.hasOwnProperty("flags")) {
                    delete item.flags;
                }
                if (item.hasOwnProperty("permission")) {
                    delete item.permission;
                }
                if (item.hasOwnProperty("folder")) {
                    delete item.folder;
                }
                if (item.hasOwnProperty("sort")) {
                    delete item.sort;
                }
                if (item.hasOwnProperty("data")) {
                    if (item.data.hasOwnProperty("description") && item.data.description.hasOwnProperty("chat")) {
                        delete item.data.description.chat;
                    }
                    if (item.data.hasOwnProperty("chatFlavor")) {
                        delete item.data.description.chatFlavor
                    }
                }
            }
        }
    }
}
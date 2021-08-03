import { SOCKET_EVENTS } from "../events/events.js";

export async function getAndEmitActorData(socket, actorId, iosSocketId) {
    let actor5eData = getCustom5eActorData();
    sanitizeActorData(actor5eData);
    sanitizeActorItems(actor5eData);
    await cleanUpActorItems(actor5eData);
    socket.emit(SOCKET_EVENTS.FOUNDRY.SEND_ACTOR_DATA, actor5eData, iosSocketId);


    // System5e puts Actor5E data on ActorData's data field
    // For some reason there is a single item field, so just make a deep copy and remove it
    // Could be done on the server with a replacer for stringify
    function getCustom5eActorData() {
        let actor = game.actors.get(actorId)
        if(actor) {
            return JSON.parse(JSON.stringify({
                "actor": {
                    "name": actor.data.name,
                    "id": actor.id,
                    "img": actor.img,
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

            if(actor5eData.actor.actorData.hasOwnProperty("details")) {
                actor5eData.actor.actorData.details.appearance = sanitizeHtml(actor5eData.actor.actorData.details.appearance);
                actor5eData.actor.actorData.details.trait = sanitizeHtml(actor5eData.actor.actorData.details.trait);
                actor5eData.actor.actorData.details.ideal = sanitizeHtml(actor5eData.actor.actorData.details.ideal);
                actor5eData.actor.actorData.details.bond = sanitizeHtml(actor5eData.actor.actorData.details.bond);
                actor5eData.actor.actorData.details.flaw = sanitizeHtml(actor5eData.actor.actorData.details.flaw);
                if(actor5eData.actor.actorData.details.hasOwnProperty("biography")) {
                    actor5eData.actor.actorData.details.biography.value = sanitizeHtml(actor5eData.actor.actorData.details.biography.value);
                    if(actor5eData.actor.actorData.details.biography.hasOwnProperty("public")) {
                        delete actor5eData.actor.actorData.details.biography.public;
                    }
                }
            }
        }
    }

    function sanitizeActorItems(actor5eData) {
        for (let item of actor5eData.actor.actorItems) {
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
                if (item.data.hasOwnProperty("description")) {
                    if(item.data.description.hasOwnProperty("chat")) {
                        delete item.data.description.chat;
                    }
                }
                if (item.data.hasOwnProperty("chatFlavor")) {
                    delete item.data.chatFlavor;
                }
            }
        }
    }

    function cleanUpActorItems(actor5eData) {
        const inventory = {
            weapon: [],
            equipment: [],
            consumable: [],
            tool: [],
            backpack: [],
            loot: []
        };

        const toDataURL = url => fetch(url)
            .then(response => response.blob())
            .then(blob => new Promise((resolve, reject) => {
                const reader = new FileReader()
                reader.onloadend = () => resolve(reader.result)
                reader.onerror = reject
                reader.readAsDataURL(blob)
            }));

        let imageDataPromises = [];
        let [items, spells, feats] = actor5eData.actor.actorItems.reduce((arr, item) => {
            if(item.type !== "class") {
                imageDataPromises.push(
                    toDataURL(item.img)
                        .then(imageData => new Promise((resolve) => {
                            resolve(item.img = imageData.split(',')[1]);
                        })))
                item.data.description.value = sanitizeHtml(item.data.description.value)
                if (item.type === "spell") {
                    arr[1].push(item);
                } else if (item.type === "feat") {
                    arr[2].push(item);
                }else if (Object.keys(inventory).includes(item.type)) {
                    arr[0].push(item);
                }
            }
            return arr;
        }, [[], [], [], []]);

        for ( let i of items ) {
            i.data.quantity = i.data.quantity || 0;
            i.data.weight = i.data.weight || 0;
            i.totalWeight = (i.data.quantity * i.data.weight).toNearest(0.1);
            inventory[i.type].push(i);
        }

        const features = {
            active: [],
            passive: []
        };

        for (let f of feats) {
            if ( f.data.activation.type ) features.active.push(f);
            else features.passive.push(f);
        }

        actor5eData.actor.actorItems = {
            "inventory": inventory,
            "spells": spells,
            "features": features
        }

        imageDataPromises.push(toDataURL(actor5eData.actor.img)
            .then(imageData => new Promise((resolve) => {
                resolve(actor5eData.actor.img = imageData.split(',')[1]);
        })));
        return Promise.all(imageDataPromises);
    }

    function sanitizeHtml(string) {
        return jQuery("<p>" + string + "</p>").text();
    }
}
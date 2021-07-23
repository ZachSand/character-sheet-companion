export function displayItemCard(socket, displayItem) {
    let displayItemObj = JSON.parse(displayItem);
    let actor = game.actors.get(displayItemObj.actorId);
    let item = actor.items.get(displayItemObj.itemId);

    if(actor && item && displayItemObj) {
        item.displayCard().then(() => {
            // do nothing
        });
    }
}
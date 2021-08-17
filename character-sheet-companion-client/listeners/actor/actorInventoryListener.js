import {
  getBase64ImageData,
  removeBase64Metadata,
  removeHtml,
} from "../../utils/commonUtilities.js";
import { SOCKET_EVENTS } from "../../constants/events.js";

export async function createAndEmitInventory(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    const inventory = {
      weapon: [],
      equipment: [],
      consumable: [],
      tool: [],
      backpack: [],
      loot: [],
    };

    await Promise.all(
      actor.items
        .filter((item) => Object.keys(inventory).includes(item.data.type))
        .map(async (item) => {
          return {
            id: item.data._id,
            name: item.data.name,
            description: removeHtml(item.data.data.description.value),
            type: item.data.type,
            hasAttack: item.hasAttack,
            hasDamage: item.hasDamage,
            quantity: Number(item.data.data.quantity) || 0,
            weight: Number(item.data.data.weight) || 0,
            cost: Number(item.data.data.price) || 0,
            image: await getBase64ImageData(item.data.img).then((imageData) => {
              return removeBase64Metadata(imageData);
            }),
            numUsagesRemaining: item.data.data.uses
              ? Number(item.data.data.uses.value)
              : 0,
            maxUsages: item.data.data.uses
              ? Number(item.data.data.uses.max)
              : 0,
          };
        })
    ).then((items) => {
      items.forEach((item) => {
        inventory[item.type].push(item);
      });
      socket.emit(
        SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_INVENTORY,
        {
          currentCapacity: actor.data.data.attributes.encumbrance.value,
          carryingCapacity: actor.data.data.attributes.encumbrance.max,
          weapons: inventory.weapon,
          equipment: inventory.equipment,
          consumables: inventory.consumable,
          tools: inventory.tool,
          containers: inventory.backpack,
          loot: inventory.loot,
        },
        iosSocketId
      );
    });
  }
}

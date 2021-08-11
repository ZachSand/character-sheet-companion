import {
  getBase64ImageData,
  removeBase64Metadata,
  removeHtml,
} from "../../utils/commonUtilities.js";
import { SOCKET_EVENTS } from "../../events/events.js";

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
            quantity: item.data.data.quantity || 0,
            weight: item.data.data.weight || 0,
            cost: item.data.data.price || 0,
            image: await getBase64ImageData(item.data.img).then((imageData) => {
              return removeBase64Metadata(imageData);
            }),
            numUsagesRemaining: item.data.data.uses
              ? item.data.data.uses.value
              : null,
            maxUsages: item.data.data.uses ? item.data.data.uses.max : null,
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
          currency: {
            copper: actor.data.data.currency.cp,
            silver: actor.data.data.currency.sp,
            electrum: actor.data.data.currency.cp,
            gold: actor.data.data.currency.gp,
            platinum: actor.data.data.currency.pp,
          },
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

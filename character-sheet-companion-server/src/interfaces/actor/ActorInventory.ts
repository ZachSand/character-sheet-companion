import { ActorInventoryItem } from "./ActorInventoryItem";
import { ActorCurrency } from "./ActorCurrency";

export interface ActorInventory {
  currentCapacity: number;
  carryingCapacity: number;
  currency: ActorCurrency;
  weapons: ActorInventoryItem[];
  equipment: ActorInventoryItem[];
  consumables: ActorInventoryItem[];
  tools: ActorInventoryItem[];
  containers: ActorInventoryItem[];
  loot: ActorInventoryItem[];
}

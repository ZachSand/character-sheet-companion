import { ActorInventoryItem } from "./ActorInventoryItem";

export interface ActorInventory {
  currentCapacity: number;
  carryingCapacity: number;
  weapons: ActorInventoryItem[];
  equipment: ActorInventoryItem[];
  consumables: ActorInventoryItem[];
  tools: ActorInventoryItem[];
  containers: ActorInventoryItem[];
  loot: ActorInventoryItem[];
}

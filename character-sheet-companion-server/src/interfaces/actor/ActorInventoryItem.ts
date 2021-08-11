export interface ActorInventoryItem {
  id: string;
  name: string;
  description: string;
  type: string;
  hasAttack: boolean;
  hasDamage: boolean;
  quantity: number;
  weight: number;
  cost: number;
  image: string;

  numUsagesRemaining?: number;
  maxUsages?: number;
}

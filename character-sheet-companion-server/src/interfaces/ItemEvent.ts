export interface ItemEvent {
  actorId: string;
  itemId: string;
  versatile: boolean;
  critical: boolean;
  advantage: boolean;
  disadvantage: boolean;
  type: string;
  spellLevel: string;
  result: number;
}

export interface ActorSpellSlot {
  id: string;
  spellLevel: number;
  spellLevelLabel: string;
  maxSpellSlots: number;
  currentSpellSlots: number;
  isPact: boolean;
}

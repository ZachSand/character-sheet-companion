export interface ActorSpell {
  id: string;
  name: string;
  description: string;
  spellLevel: number;
  hasAttack: boolean;
  hasDamage: boolean;
  isHealing: boolean;
  prepared: boolean;
  image: string;
}

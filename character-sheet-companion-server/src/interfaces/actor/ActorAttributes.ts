import { DeathSaves } from "./DeathSaves";
import { Encumbrance } from "./Encumbrance";
import { Movement } from "./Movement";

export interface ActorAttributes {
  armorClass: number;
  currentHealth: number;
  maxHealth: number;
  proficiencyBonus: number;
  initiativeBonus: number;
  deathSaves: DeathSaves;
  inspiration: boolean;
  encumbrance: Encumbrance;
  exhaustion: number;
  hitDice: number;
  movement: Movement;
  spellDiceCheck: number;
  spellCasting: string;
}

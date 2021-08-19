import { ActorDeathSaves } from "./ActorDeathSaves";
import { ActorEncumbrance } from "./ActorEncumbrance";
import { ActorMovement } from "./ActorMovement";

export interface ActorAttributes {
  armorClass: number;
  currentHealth: number;
  maxHealth: number;
  proficiencyBonus: number;
  initiativeBonus: number;
  deathSaves: ActorDeathSaves;
  inspiration: boolean;
  encumbrance: ActorEncumbrance;
  exhaustion: number;
  hitDice: number;
  movement: ActorMovement;
  spellDiceCheck: number;
  spellCasting: string;
}

export interface ActorAbilities {
  abilities: ActorAbility[];
}

export interface ActorAbility {
  id: string;
  name: string;
  bonusModifier: number;
  totalScore: number;
  bonusSaveModifier: number;
}

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

export interface ActorBaseData {
  id: string;
  name: string;
  image: string;
}

export interface ActorClasses {
  classes: ActorClass[];
}

export interface ActorClass {
  id: string;
  description: string;
  levels: number;
  subclass: string;
  hitDice: string;
  hitDiceUsed: number;
}

export interface ActorCurrency {
  copper: number;
  silver: number;
  electrum: number;
  gold: number;
  platinum: number;
}

export interface ActorDeathSaves {
  success: number;
  failure: number;
}

export interface ActorDetails {
  biography: string;
  appearance: string;
  flaws: string;
  bonds: string;
  personalityTraits: string;
  ideals: string;
}

export interface ActorEncumbrance {
  currentValue: number;
  maxValue: number;
}

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
  numUsagesRemaining: number;
  maxUsages: number;
}

export interface ActorMovement {
  burrow: number;
  climb: number;
  fly: number;
  hover: boolean;
  swim: number;
  units: string;
  walk: number;
}

export interface ActorSenses {
  blindsight: number;
  darkvision: number;
  special: string;
  tremorsense: number;
  truesight: number;
  units: string;
}

export interface ActorSkill {
  id: string;
  name: string;
  proficient: boolean;
  abilityModifier: string;
  bonusModifier: number;
  passiveValue: number;
}

export interface ActorSkills {
  skills: ActorSkill[];
}

export interface ActorSpells {
  spells: ActorSpell[];
}

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

export interface ActorSpellSlots {
  spellSlots: ActorSpellSlot[];
}

export interface ActorSpellSlot {
  id: string;
  spellLevel: number;
  spellLevelLabel: string;
  maxSpellSlots: number;
  currentSpellSlots: number;
  isPact: boolean;
}

export interface ActorTraits {
  languages: string[];
  size: string;
  toolProficiencies: string[];
  weaponProficiencies: string[];
  armorProficiencies: string[];
  damageImmunities: string[];
  damageResistances: string[];
  damageVulnerabilities: string[];
  conditionImmunities: string[];
  senses: ActorSenses;
}

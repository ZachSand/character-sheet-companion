export interface ActorData {
  actorData: ActorData;
  actorItems: ActorItems;
  name: string;
  id: string;
  img: string;
}

export interface ActorData {
  abilities: Abilities;
  attributes: Attributes;
  details: Details;
  traits: Traits;
  currency: Currency;
  skills: { [key: string]: Skill };
  spells: Spells;
  bonuses: Bonuses;
  resources: Resources;
  prof: number;
  classes: Class[];
  mod: number;
}

export interface ActorItems {
  inventory: Inventory;
  spells: ActorItem[];
  features: Features;
}

export interface Features {
  active: ActorItem[];
  passive: ActorItem[];
}

export interface Inventory {
  weapon: ActorItem[];
  equipment: ActorItem[];
  consumable: ActorItem[];
  tool: ActorItem[];
  backpack: ActorItem[];
  loot: ActorItem[];
}

export interface Abilities {
  str: Ability;
  dex: Ability;
  con: Ability;
  int: Ability;
  wis: Ability;
  cha: Ability;
}

export interface Ability {
  value: number;
  proficient: number;
  min: number;
  max: number;
  mod: number;
  prof: number;
  saveBonus: number;
  checkBonus: number;
  save: number;
  dc: number;
}

export interface Attributes {
  ac: AC;
  hp: AttributesHP;
  init: Init;
  movement: Movement;
  senses: Senses;
  spellcasting: string;
  death: Death;
  exhaustion: number;
  inspiration: boolean;
  hd: number;
  prof: number;
  spelldc: number;
  encumbrance: Encumbrance;
}

export interface AC {
  value: number;
  type: string;
  label: string;
}

export interface Death {
  success: number;
  failure: number;
}

export interface Encumbrance {
  value: number;
  max: number;
  pct: number;
  encumbered?: boolean;
  min?: number;
}

export interface AttributesHP {
  value: number;
  min: number;
  max: number;
  temp: null;
  tempmax: null;
}

export interface Init {
  value: number;
  bonus: number;
  mod: number;
  prof: number;
  total: number;
}

export interface Movement {
  burrow: number;
  climb: number;
  fly: number;
  swim: number;
  walk: number;
  units: string;
  hover: boolean;
}

export interface Senses {
  darkvision: number;
  blindsight: number;
  tremorsense: number;
  truesight: number;
  units: string;
  special: string;
}

export interface Bonuses {
  mwak: Msak;
  rwak: Msak;
  msak: Msak;
  rsak: Msak;
  abilities: BonusesAbilities;
  spell: SpellDC;
}

export interface BonusesAbilities {
  check: string;
  save: string;
  skill: string;
}

export interface Msak {
  attack: string;
  damage: string;
}

export interface SpellDC {
  dc: number;
}

export interface Class {
  description: ClassDescription;
  source: string;
  levels: number;
  subclass: string;
  hitDice: string;
  hitDiceUsed: number;
  saves: string[];
  skills: Skills;
  spellcasting: Spellcasting;
  name: string;
}

export interface ClassDescription {
  value: string;
  chat: string;
  unidentified: boolean;
}

export interface Skills {
  number: number;
  choices: string[];
  value: string[];
}

export interface Spellcasting {
  progression: string;
  ability: string;
}

export interface Currency {
  pp: number;
  gp: number;
  ep: number;
  sp: number;
  cp: number;
}

export interface Details {
  biography: Biography;
  alignment: string;
  race: string;
  background: string;
  originalClass: string;
  xp: Encumbrance;
  appearance: string;
  trait: string;
  ideal: string;
  bond: string;
  flaw: string;
  gender: string;
  age: number;
  height: string;
  weight: number;
  eyes: string;
  skin: string;
  hair: string;
  level: number;
}

export interface Biography {
  value: string;
}

export interface Resources {
  primary: Resource;
  secondary: Resource;
  tertiary: Resource;
}

export interface Resource {
  value: number;
  max: number;
  sr: boolean;
  lr: boolean;
  label: string;
}

export interface Skill {
  value: number;
  ability: string;
  type: string;
  label: string;
  mod: number;
  bonus: number;
  prof: number;
  total: number;
  passive: number;
}

export interface Spells {
  spell0: Spell;
  spell1: Spell;
  spell2: Spell;
  spell3: Spell;
  spell4: Spell;
  spell5: Spell;
  spell6: Spell;
  spell7: Spell;
  spell8: Spell;
  spell9: Spell;
  pact: Spell;
}

export interface Spell {
  value: number;
  override: null;
  max: number;
  level?: number;
}

export interface Traits {
  size: string;
  di: Trait;
  dr: Trait;
  dv: Trait;
  ci: Trait;
  languages: Trait;
  weaponProf: Trait;
  armorProf: Trait;
  toolProf: Trait;
  senses: Senses;
}

export interface Trait {
  value: string[];
  custom: string;
}

export interface ActorItem {
  id: string;
  name: string;
  type: string;
  img: string;
  data: ItemData;
  effects: any[];
}

export interface ItemData {
  description: ItemDescription;
  source: null | string;
  levels?: number;
  subclass?: string;
  hitDice?: string;
  hitDiceUsed?: number;
  saves?: string[];
  skills?: Skills;
  spellcasting?: Spellcasting;
  activation?: Activation;
  duration?: Duration;
  target?: Range;
  range?: Range;
  uses?: Uses;
  consume?: Consume;
  ability?: string[] | null | string;
  actionType?: null | string;
  attackBonus?: number | string;
  chatFlavor?: string;
  critical?: null;
  damage?: Damage;
  formula?: string;
  save?: Save;
  requirements?: string;
  recharge?: Recharge;
  quantity?: number;
  weight?: number;
  price?: number;
  attuned?: boolean;
  attunement?: number;
  equipped?: boolean;
  rarity?: string;
  identified?: boolean;
  armor?: Armor;
  hp?: DataHP;
  weaponType?: string;
  properties?: { [key: string]: boolean };
  proficient?: boolean | number;
  speed?: Speed;
  strength?: number;
  stealth?: boolean;
  consumableType?: string;
  capacity?: Capacity;
  currency?: Currency;
  level?: number;
  school?: string;
  components?: Components;
  materials?: Materials;
  preparation?: Preparation;
  scaling?: Scaling;
}

export interface Activation {
  type: string;
  cost: number;
  condition: string;
}

export interface Armor {
  value: number;
  type?: string;
  dex?: null;
}

export interface Capacity {
  type: string;
  value: number;
  weightless: boolean;
}

export interface Components {
  value: string;
  vocal: boolean;
  somatic: boolean;
  material: boolean;
  ritual: boolean;
  concentration: boolean;
}

export interface Consume {
  type: string;
  target: null | string;
  amount: null;
}

export interface Damage {
  parts: Array<string[]>;
  versatile: string;
  value?: string;
}

export interface ItemDescription {
  value: string;
  unidentified: boolean | string;
}

export interface Duration {
  value: number | null | string;
  units: string;
}

export interface DataHP {
  value: number;
  max: number;
  dt: null;
  conditions: string;
}

export interface Materials {
  value: string;
  consumed: boolean;
  cost: number;
  supply: number;
}

export interface Preparation {
  mode: string;
  prepared: boolean;
}

export interface Range {
  value: number | null;
  long?: number | null | string;
  units: null | string;
  type?: null | string;
  width?: null;
}

export interface Recharge {
  value: null;
  charged: boolean;
}

export interface Save {
  ability: string;
  dc: null;
  scaling: string;
}

export interface Scaling {
  mode: string;
  formula: string;
}

export interface Speed {
  value: null;
  conditions: string;
}

export interface Uses {
  value: number | null;
  max: number | null | string;
  per: null | string;
  autoDestroy?: boolean;
  autoUse?: boolean;
}

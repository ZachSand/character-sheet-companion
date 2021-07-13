export interface Actor {
  id: string;
  name: string;
  type: string;
  img: string;
  data: ActorData;
  token: Token;
  items: Item[];
  effects: Effect[];
  folder: null;
  sort: number;
  permission: never;
  flags: never;
}

export interface ActorData {
  abilities: Abilities;
  attributes: Attributes;
  details: Details;
  traits: Traits;
  currency: Currency;
  skills: { [key: string]: Skill };
  spells: { [key: string]: SpellValue };
  bonuses: Bonuses;
  resources: Resources;
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
}

export interface Attributes {
  ac: number;
  hp: AttributesHP;
  init: Init;
  movement: Movement;
  senses: Senses;
  spellcasting: string;
  death: Death;
  exhaustion: number;
  inspiration: boolean;
}

export interface Death {
  success: number;
  failure: number;
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
  spell: BonusesSpell;
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

export interface BonusesSpell {
  dc: string;
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
  xp: XP;
  appearance: string;
  trait: string;
  ideal: string;
  bond: string;
  flaw: string;
}

export interface Biography {
  value: string;
  public: string;
}

export interface XP {
  value: number;
  min: number;
  max: number;
}

export interface Resources {
  primary: Resource;
  secondary: Resource;
  tertiary: Resource;
}

export interface Resource {
  value: null;
  max: null;
  sr: boolean;
  lr: boolean;
  label: string;
}

export interface Skill {
  value: number;
  ability: string;
}

export interface SpellValue {
  value: number;
  override: null;
}

export interface Traits {
  size: string;
  di: TraitData;
  dr: TraitData;
  dv: TraitData;
  ci: TraitData;
  languages: TraitData;
  weaponProf: TraitData;
  armorProf: TraitData;
  toolProf: TraitData;
}

export interface TraitData {
  value: string[];
  custom: string;
}

export interface Effect {
  id: string;
  changes: Change[];
  disabled: boolean;
  duration: EffectDuration;
  icon: string;
  label: string;
  origin: string;
  tint: null;
  transfer: boolean;
  flags: never;
}

export interface Change {
  key: string;
  value: string;
  mode: number;
}

export interface EffectDuration {
  startTime: number | null;
  seconds: number;
  rounds: number;
}

export interface Item {
  id: string;
  name: string;
  type: string;
  img: string;
  data: ItemData;
  effects: Effect[];
  folder: null;
  sort: number;
  permission: never;
  flags: ItemFlags;
}

export interface ItemData {
  description: ItemDescription;
  source: string;
  activation?: Activation;
  duration?: DataDuration;
  target?: Target;
  range?: Range;
  uses?: Uses;
  consume?: Consume;
  ability?: null | string;
  actionType?: null | string;
  attackBonus?: number;
  chatFlavor?: string;
  critical?: null;
  damage: DamageClass;
  formula?: string;
  save?: Save;
  requirements?: string;
  recharge?: Recharge;
  quantity?: number;
  weight?: number;
  price?: number | string;
  attuned?: boolean;
  attunement?: number;
  equipped?: boolean;
  rarity?: string;
  identified?: boolean;
  armor?: Armor;
  hp?: ItemHp;
  weaponType?: string;
  properties?: { [key: string]: boolean };
  proficient?: boolean | number;
  attributes?: ItemAttributes;
  bonus?: never;
  damageType?: never;
  damage2?: never;
  damage2Type?: never;
  speed?: Speed;
  strength?: number | string;
  stealth?: boolean;
  levels?: number;
  subclass?: string;
  hitDice?: string;
  hitDiceUsed?: number;
  saves?: string[];
  skills?: Skills;
  spellcasting?: Spellcasting;
  level?: number;
  school?: string;
  components?: Components;
  materials?: Materials;
  preparation?: Preparation;
  scaling?: ScalingClass;
  capacity?: Capacity;
  currency?: Currency;
  consumableType?: string;
}

export interface Activation {
  type: string;
  cost: number | null;
  condition: string;
}

export interface Armor {
  value: number | null;
  type?: string;
  dex?: number | null;
  label?: string;
}

export interface ItemAttributes {
  spelldc: number;
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

export interface DamageClass {
  parts: Array<string[]>;
  versatile?: string;
  value?: string;
}

export interface ItemDescription {
  value: string;
  chat: string;
  unidentified: string;
  type?: string;
  label?: string;
}

export interface DataDuration {
  value: number | null | string;
  units: string;
}

export interface ItemHp {
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
  value: number | null | string;
  long: number | null;
  units: string;
}

export interface Recharge {
  value: null;
  charged: boolean;
}

export interface Save {
  ability: string;
  dc: number | null;
  scaling: string;
  value?: string;
}

export interface ScalingClass {
  mode: string;
  formula: string;
}

export interface Skills {
  number: number;
  choices: string[];
  value: string[];
}

export interface Speed {
  value: null;
  conditions: string;
}

export interface Spellcasting {
  progression: string;
  ability: string;
}

export interface Target {
  value: number | null | string;
  width: null;
  units: string | null;
  type: string;
}

export interface Uses {
  value: number;
  max: number | string;
  per: null | string;
  type?: string;
  autoDestroy?: boolean;
  autoUse?: boolean;
}

export interface ItemFlags {
  core?: Core;
  exportSource?: ExportSource;
}

export interface Core {
  sourceID: string;
}

export interface ExportSource {
  world: string;
  system: string;
  coreVersion: string;
  systemVersion: string;
}

export interface Token {
  name: string;
  img: string;
  displayName: number;
  actorLink: boolean;
  width: number;
  height: number;
  scale: number;
  mirrorX: boolean;
  mirrorY: boolean;
  lockRotation: boolean;
  rotation: number;
  alpha: number;
  vision: boolean;
  dimSight: number;
  brightSight: number;
  dimLight: number;
  brightLight: number;
  sightAngle: number;
  lightAngle: number;
  lightAlpha: number;
  lightAnimation: LightAnimation;
  disposition: number;
  displayBars: number;
  bar1: Bar;
  bar2: Bar;
  flags: never;
  randomImg: boolean;
}

export interface Bar {
  attribute: null | string;
}

export interface LightAnimation {
  speed: number;
  intensity: number;
}

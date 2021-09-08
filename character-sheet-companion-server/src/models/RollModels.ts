export interface RollAbility {
  actorId: string;
  ability: string;
  advantage: boolean;
  disadvantage: boolean;
  isSave: boolean;
  result: number;
}

export interface RollDeathSave {
  actorId: string;
  advantage: boolean;
  disadvantage: boolean;
  result: number;
}

export interface RollHitDie {
  actorId: string;
  hitDie: string;
  result: number;
}

export interface RollInitiative {
  actorId: string;
  result: string;
}

export interface RollItemAttack {
  actorId: string;
  itemId: string;
  advantage: boolean;
  disadvantage: boolean;
  result: number;
}

export interface RollItemConsume {
  actorId: string;
  itemId: string;
  consume: boolean;
}

export interface RollItemDamage {
  actorId: string;
  itemId: string;
  critical: boolean;
  versatile: boolean;
  result: number;
}

export interface RollItemTool {
  actorId: string;
  itemId: string;
  advantage: boolean;
  disadvantage: boolean;
  result: number;
}

export interface RollSkill {
  actorId: string;
  skill: string;
  advantage: boolean;
  disadvantage: boolean;
  result: number;
}

import { ActorSenses } from "./ActorSenses";

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

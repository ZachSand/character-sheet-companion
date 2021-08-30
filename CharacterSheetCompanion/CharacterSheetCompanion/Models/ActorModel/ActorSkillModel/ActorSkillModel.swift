//
//  SkillModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct ActorSkillModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var proficient: Bool
    var abilityModifier: String
    var bonusModifier: Int
    var passiveValue: Int
}

#if DEBUG
    extension ActorSkillModel {
        static let mockedData = [
            ActorSkillModel(id: "acr", name: "Acrobatics", proficient: false, abilityModifier: "dex", bonusModifier: 4, passiveValue: 18),
            ActorSkillModel(id: "ani", name: "Animal Handling", proficient: false, abilityModifier: "wis", bonusModifier: 2, passiveValue: 14),
            ActorSkillModel(id: "arc", name: "Arcana", proficient: false, abilityModifier: "int", bonusModifier: 1, passiveValue: 12),
            ActorSkillModel(id: "ath", name: "Athletics", proficient: false, abilityModifier: "str", bonusModifier: 0, passiveValue: 11),
            ActorSkillModel(id: "dec", name: "Deception", proficient: false, abilityModifier: "cha", bonusModifier: 2, passiveValue: 14),
            ActorSkillModel(id: "his", name: "History", proficient: false, abilityModifier: "int", bonusModifier: 1, passiveValue: 12),
            ActorSkillModel(id: "ins", name: "Insight", proficient: true, abilityModifier: "wis", bonusModifier: 5, passiveValue: 15),
            ActorSkillModel(id: "itm", name: "Intimidation", proficient: false, abilityModifier: "cha", bonusModifier: 2, passiveValue: 14),
            ActorSkillModel(id: "inv", name: "Investigation", proficient: false, abilityModifier: "int", bonusModifier: 1, passiveValue: 12),
            ActorSkillModel(id: "med", name: "Medicine", proficient: false, abilityModifier: "wis", bonusModifier: 2, passiveValue: 14),
            ActorSkillModel(id: "nat", name: "Nature", proficient: false, abilityModifier: "int", bonusModifier: 1, passiveValue: 12),
            ActorSkillModel(id: "prc", name: "Perception", proficient: true, abilityModifier: "wis", bonusModifier: 5, passiveValue: 15),
            ActorSkillModel(id: "prf", name: "Performance", proficient: false, abilityModifier: "cha", bonusModifier: 2, passiveValue: 14),
            ActorSkillModel(id: "per", name: "Persuasion", proficient: true, abilityModifier: "cha", bonusModifier: 8, passiveValue: 12),
            ActorSkillModel(id: "rel", name: "Religion", proficient: false, abilityModifier: "int", bonusModifier: -1, passiveValue: 11),
            ActorSkillModel(id: "slt", name: "Sleight of Hand", proficient: false, abilityModifier: "dex", bonusModifier: 4, passiveValue: 18),
            ActorSkillModel(id: "ste", name: "Stealth", proficient: true, abilityModifier: "dex", bonusModifier: 10, passiveValue: 18),
            ActorSkillModel(id: "sur", name: "Survival", proficient: false, abilityModifier: "wis", bonusModifier: 2, passiveValue: 14),
        ]
    }
#endif

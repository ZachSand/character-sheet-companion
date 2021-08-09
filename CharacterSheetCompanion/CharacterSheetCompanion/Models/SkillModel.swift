//
//  SkillModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct SkillModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var proficient: Bool
    var abilityModifier: String
    var bonusModifier: Int
    var passiveValue: Int
}

#if DEBUG
    extension SkillModel {
        static let mockedData = [
            SkillModel(id: "acr", name: "Acrobatics", proficient: false, abilityModifier: "dex", bonusModifier: 4, passiveValue: 18),
            SkillModel(id: "ani", name: "Animal Handling", proficient: false, abilityModifier: "wis", bonusModifier: 2, passiveValue: 14),
            SkillModel(id: "arc", name: "Arcana", proficient: false, abilityModifier: "int", bonusModifier: 1, passiveValue: 12),
            SkillModel(id: "ath", name: "Athletics", proficient: false, abilityModifier: "str", bonusModifier: 0, passiveValue: 11),
            SkillModel(id: "dec", name: "Deception", proficient: false, abilityModifier: "cha", bonusModifier: 2, passiveValue: 14),
            SkillModel(id: "his", name: "History", proficient: false, abilityModifier: "int", bonusModifier: 1, passiveValue: 12),
            SkillModel(id: "ins", name: "Insight", proficient: true, abilityModifier: "wis", bonusModifier: 5, passiveValue: 15),
            SkillModel(id: "itm", name: "Intimidation", proficient: false, abilityModifier: "cha", bonusModifier: 2, passiveValue: 14),
            SkillModel(id: "inv", name: "Investigation", proficient: false, abilityModifier: "int", bonusModifier: 1, passiveValue: 12),
            SkillModel(id: "med", name: "Medicine", proficient: false, abilityModifier: "wis", bonusModifier: 2, passiveValue: 14),
            SkillModel(id: "nat", name: "Nature", proficient: false, abilityModifier: "int", bonusModifier: 1, passiveValue: 12),
            SkillModel(id: "prc", name: "Perception", proficient: true, abilityModifier: "wis", bonusModifier: 5, passiveValue: 15),
            SkillModel(id: "prf", name: "Performance", proficient: false, abilityModifier: "cha", bonusModifier: 2, passiveValue: 14),
            SkillModel(id: "per", name: "Persuasion", proficient: true, abilityModifier: "cha", bonusModifier: 8, passiveValue: 12),
            SkillModel(id: "rel", name: "Religion", proficient: false, abilityModifier: "int", bonusModifier: -1, passiveValue: 11),
            SkillModel(id: "slt", name: "Sleight of Hand", proficient: false, abilityModifier: "dex", bonusModifier: 4, passiveValue: 18),
            SkillModel(id: "ste", name: "Stealth", proficient: true, abilityModifier: "dex", bonusModifier: 10, passiveValue: 18),
            SkillModel(id: "sur", name: "Survival", proficient: false, abilityModifier: "wis", bonusModifier: 2, passiveValue: 14),
        ]
    }
#endif

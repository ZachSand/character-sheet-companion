//
//  ActorTraitsModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

struct ActorTraitsModel: Codable {
    var languages: [String]
    var size: String
    var toolProficiencies: [String]
    var weaponProficiencies: [String]
    var armorProficiencies: [String]
    var damageImmunities: [String]
    var damageResistances: [String]
    var damageVulnerabilities: [String]
    var conditionImmunities: [String]
    var senses: ActorSensesModel
}

#if DEBUG
    extension ActorTraitsModel {
        static let mockedData = ActorTraitsModel(
            languages: ["Common", "Celestial", "Elvish"],
            size: "Medium",
            toolProficiencies: ["Dice Set"],
            weaponProficiencies: ["Martial Weapons"],
            armorProficiencies: ["Light Armor", "Medium Armor"],
            damageImmunities: ["Fire", "Lighning"],
            damageResistances: ["Radiant", "Cold"],
            damageVulnerabilities: ["Slashing"],
            conditionImmunities: ["Dazed", "Charmed"],
            senses: ActorSensesModel.mockedData
        )
    }
#endif

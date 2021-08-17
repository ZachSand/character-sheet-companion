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

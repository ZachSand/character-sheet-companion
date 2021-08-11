//
//  AbilityModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/7/21.
//

import Foundation

struct ActorAbilityModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var bonusModifier: Int
    var totalScore: Int
    var bonusSaveModifier: Int
}

#if DEBUG
    extension ActorAbilityModel {
        static let mockedData = [
            ActorAbilityModel(id: "str", name: "Strength", bonusModifier: 0, totalScore: 11, bonusSaveModifier: 0),
            ActorAbilityModel(id: "dex", name: "Dexterity", bonusModifier: 4, totalScore: 18, bonusSaveModifier: 7),
            ActorAbilityModel(id: "con", name: "Constitution", bonusModifier: 2, totalScore: 14, bonusSaveModifier: 2),
            ActorAbilityModel(id: "int", name: "Intelligence", bonusModifier: 1, totalScore: 12, bonusSaveModifier: 4),
            ActorAbilityModel(id: "wis", name: "Wisdom", bonusModifier: 2, totalScore: 14, bonusSaveModifier: 2),
            ActorAbilityModel(id: "str", name: "Strength", bonusModifier: 2, totalScore: 14, bonusSaveModifier: 2),
        ]
    }
#endif

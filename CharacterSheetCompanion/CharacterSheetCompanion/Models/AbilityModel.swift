//
//  AbilityModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/7/21.
//

import Foundation

struct AbilityModel: Identifiable {
    var id: String
    var name: String
    var bonusModifier: Int
    var totalScore: Int
    var bonusSaveModifier: Int
}

#if DEBUG
    extension AbilityModel {
        static let mockedData = [
            AbilityModel(id: "str", name: "Strength", bonusModifier: 0, totalScore: 11, bonusSaveModifier: 0),
            AbilityModel(id: "dex", name: "Dexterity", bonusModifier: 4, totalScore: 18, bonusSaveModifier: 7),
            AbilityModel(id: "con", name: "Constitution", bonusModifier: 2, totalScore: 14, bonusSaveModifier: 2),
            AbilityModel(id: "int", name: "Intelligence", bonusModifier: 1, totalScore: 12, bonusSaveModifier: 4),
            AbilityModel(id: "wis", name: "Wisdom", bonusModifier: 2, totalScore: 14, bonusSaveModifier: 2),
            AbilityModel(id: "str", name: "Strength", bonusModifier: 2, totalScore: 14, bonusSaveModifier: 2),
        ]
    }
#endif

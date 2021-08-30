//
//  ActorClassModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

struct ActorClassModel: Codable, Identifiable, Hashable {
    var id: String
    var description: String
    var levels: Int
    var subclass: String
    var hitDice: String
    var hitDiceUsed: Int
}

#if DEBUG
    extension ActorClassModel {
        static let mockedData = [
            ActorClassModel(
                id: "warlock",
                description: "A warlock",
                levels: 3,
                subclass: "The Celestial",
                hitDice: "d8",
                hitDiceUsed: 1
            ),
            ActorClassModel(
                id: "sorcerer",
                description: "A sorcerer",
                levels: 2,
                subclass: "",
                hitDice: "d6",
                hitDiceUsed: 0
            ),
        ]
    }
#endif

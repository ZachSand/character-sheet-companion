//
//  ActorOverviewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/6/21.
//

import Foundation

struct ActorAttributesModel: Codable, BaseModel {
    var armorClass: Int
    var currentHealth: Int
    var maxHealth: Int
    var proficiencyBonus: Int
    var initiativeBonus: Int
    var deathSaves: ActorDeathSavesModel
    var inspiration: Bool
    var encumbrance: ActorEncumbranceModel
    var exhaustion: Int
    var hitDice: Int
    var movement: ActorMovementModel
    var spellDiceCheck: Int
    var spellCasting: String

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ACTOR.ATTRIBUTES
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.ATTRIBUTES
    }
}

#if DEBUG
    extension ActorAttributesModel {
        static let mockedData = ActorAttributesModel(
            armorClass: 16,
            currentHealth: 12,
            maxHealth: 102,
            proficiencyBonus: 5,
            initiativeBonus: 7,
            deathSaves: ActorDeathSavesModel(success: 1, failure: 2),
            inspiration: true,
            encumbrance: ActorEncumbranceModel(currentValue: 125.0, maxValue: 120.0),
            exhaustion: 1,
            hitDice: 6,
            movement: ActorMovementModel(burrow: 0, climb: 15, fly: 60, hover: false, swim: 0, units: "ft", walk: 50),
            spellDiceCheck: 13,
            spellCasting: "int"
        )
    }
#endif

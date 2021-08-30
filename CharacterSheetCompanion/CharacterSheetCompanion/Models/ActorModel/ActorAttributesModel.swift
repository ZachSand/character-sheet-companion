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
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_ATTRIBUTES
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_ATTRIBUTES
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_ATTRIBUTES = "ios:requestActorAttributes"
    static let REQUEST_ACTOR_HEALTH_CHANGE = "ios:requestActorHealthChange"
    static let REQUEST_ACTOR_SHORT_REST = "ios:requestActorShortRest"
    static let REQUEST_ACTOR_LONG_REST = "ios:requestActorLongRest"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_ATTRIBUTES = "server:sendActorAttributes"
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

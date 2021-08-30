//
//  ActorTraitsModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

struct ActorTraitsModel: Codable, BaseModel {
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

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_TRAITS
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_TRAITS
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_TRAITS = "ios:requestActorTraits"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_TRAITS = "server:sendActorTraits"
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

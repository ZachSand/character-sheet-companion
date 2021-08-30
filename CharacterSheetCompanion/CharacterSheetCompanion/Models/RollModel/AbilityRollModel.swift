//
//  AbilityRoll.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/15/21.
//

import Foundation

struct AbilityRollModel: BaseRollModel {
    var actorId: String
    var ability: String
    var advantage: Bool
    var disadvantage: Bool
    var isSave: Bool
    var result: Int

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_ABILITY_ROLL
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_ABILITY_ROLL
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_ABILITY_ROLL = "ios:requestFoundryAbilityRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_ABILITY_ROLL = "server:sendFoundryAbilityRoll"
}

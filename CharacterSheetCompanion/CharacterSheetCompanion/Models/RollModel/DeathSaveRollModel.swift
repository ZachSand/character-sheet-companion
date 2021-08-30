//
//  DeathSaveRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import Foundation

struct DeathSaveRollModel: BaseRollModel {
    var actorId: String
    var advantage: Bool
    var disadvantage: Bool
    var result: Int

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_ITEM_ATTACK_ROLL
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_ATTACK_ROLL
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_DEATH_SAVE_ROLL = "ios:requestFoundryDeathSaveRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_DEATH_SAVE_ROLL = "foundry:sendDeathSaveRoll"
}

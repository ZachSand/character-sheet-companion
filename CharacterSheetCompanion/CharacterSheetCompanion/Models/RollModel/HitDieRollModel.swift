//
//  HitDiceRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/23/21.
//

import Foundation

struct HitDieRollModel: BaseRollModel {
    var actorId: String
    var hitDie: String
    var result: Int

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_HIT_DIE_ROLL
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ROLL.SEND.SEND_HIT_DIE_ROLL
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_HIT_DIE_ROLL = "ios:requestFoundryHitDieRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_HIT_DIE_ROLL = "foundry:sendHitDieRoll"
}

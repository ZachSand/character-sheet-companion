//
//  ItemAttackRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/21/21.
//

import Foundation

struct ItemAttackRollModel: BaseRollModel {
    var actorId: String
    var itemId: String
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
    static let REQUEST_FOUNDRY_ITEM_ATTACK_ROLL = "ios:requestFoundryItemAttackRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_ITEM_ATTACK_ROLL = "server:sendFoundryItemAttackRoll"
}

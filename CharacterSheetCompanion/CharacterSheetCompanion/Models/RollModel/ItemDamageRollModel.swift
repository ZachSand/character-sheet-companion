//
//  ItemDamageModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/26/21.
//

import Foundation

struct ItemDamageRollModel: BaseRollModel {
    var actorId: String
    var itemId: String
    var critical: Bool
    var versatile: Bool
    var result: Int

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_DAMAGE_ROLL
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL = "ios:requestFoundryItemDamageRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_ITEM_DAMAGE_ROLL = "server:sendFoundryItemDamageRoll"
}

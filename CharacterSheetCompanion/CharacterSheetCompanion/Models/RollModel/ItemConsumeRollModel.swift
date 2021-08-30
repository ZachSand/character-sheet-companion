//
//  ItemConsumeModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/28/21.
//

import Foundation

struct ItemConsumeRollModel: BaseRollModel {
    var actorId: String
    var itemId: String
    var consume: Bool
    var result: Int

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_CONSUME_ROLL
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_ITEM_CONSUME_ROLL = "ios:requestFoundryItemConsumeRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_ITEM_CONSUME_ROLL = "server:sendFoundryItemConsumeRoll"
}

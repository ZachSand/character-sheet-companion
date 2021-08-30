//
//  ItemToolRollModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/28/21.
//

import Foundation

struct ItemToolRollModel: BaseRollModel {
    var actorId: String
    var itemId: String
    var advantage: Bool
    var disadvantage: Bool
    var result: Int

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_ITEM_TOOL_ROLL
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_TOOL_ROLL
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_ITEM_TOOL_ROLL = "ios:requestFoundryItemToolRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_ITEM_TOOL_ROLL = "server:sendFoundryItemToolRoll"
}

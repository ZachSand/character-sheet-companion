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
        REQUEST_EVENTS.ROLL.ITEM_TOOL
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.ITEM_TOOL
    }
}

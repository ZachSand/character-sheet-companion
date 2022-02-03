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
        REQUEST_EVENTS.ROLL.ITEM_DAMAGE
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.ITEM_DAMAGE
    }
}

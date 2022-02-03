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
        REQUEST_EVENTS.ROLL.ITEM_CONSUME
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.ITEM_CONSUME
    }
}

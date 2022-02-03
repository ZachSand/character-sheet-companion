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
        REQUEST_EVENTS.ROLL.ITEM_ATTACK
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.ITEM_ATTACK
    }
}

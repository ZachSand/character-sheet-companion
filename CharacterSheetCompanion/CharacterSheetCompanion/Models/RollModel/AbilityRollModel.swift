//
//  AbilityRoll.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/15/21.
//

import Foundation

struct AbilityRollModel: BaseRollModel {
    var actorId: String
    var ability: String
    var advantage: Bool
    var disadvantage: Bool
    var isSave: Bool
    var result: Int

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ROLL.ABILITY
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.ABILITY
    }
}

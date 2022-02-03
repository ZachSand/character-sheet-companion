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
        REQUEST_EVENTS.ROLL.HIT_DIE
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.HIT_DIE
    }
}

//
//  DeathSaveRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import Foundation

struct DeathSaveRollModel: BaseRollModel {
    var actorId: String
    var advantage: Bool
    var disadvantage: Bool
    var result: Int

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ROLL.DEATH_SAVE
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.DEATH_SAVE
    }
}

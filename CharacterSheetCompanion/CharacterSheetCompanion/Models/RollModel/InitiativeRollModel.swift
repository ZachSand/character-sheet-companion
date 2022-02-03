//
//  InitiativeRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation

struct InitiativeRollModel: BaseRollModel {
    var actorId: String
    var result: Int

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ROLL.INITIATIVE
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.INITIATIVE
    }
}

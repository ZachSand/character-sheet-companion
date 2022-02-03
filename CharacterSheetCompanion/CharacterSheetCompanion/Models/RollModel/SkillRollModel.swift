//
//  SkillRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/16/21.
//

import Foundation

struct SkillRollModel: BaseRollModel {
    var actorId: String
    var skill: String
    var advantage: Bool
    var disadvantage: Bool
    var result: Int

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ROLL.SKILL
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ROLL.SKILL
    }
}

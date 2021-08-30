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
        SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_SKILL_ROLL
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_SKILL_ROLL
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_SKILL_ROLL = "ios:requestFoundrySkillRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_SKILL_ROLL = "server:sendFoundrySkillRoll"
}

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
        SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_INITIATIVE_ROLL
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ROLL.SEND.SEND_INITIATIVE_ROLL
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_INITIATIVE_ROLL = "ios:requestFoundryInitiativeRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_INITIATIVE_ROLL = "foundry:sendInitiativeRoll"
}

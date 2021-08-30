//
//  SetupUserAuthModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

struct SetupUserAuthModel: BaseModel {
    var id: String
    var password: String
    var passwordMatches: Bool

    static func getRequestEvent() -> String {
        SocketEvents.IOS.SETUP.REQUEST_USER_AUTH
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.SETUP.SEND.SEND_FOUNDRY_USER_AUTH
    }
}

extension SocketEvents.IOS.SETUP {
    static let REQUEST_USER_AUTH = "ios:requestFoundryUserAuthentication"
}

extension SocketEvents.SERVER.SETUP.SEND {
    static let SEND_FOUNDRY_USER_AUTH = "server:sendFoundryUserAuthentication"
}

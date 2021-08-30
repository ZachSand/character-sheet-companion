//
//  SetupUserArrayModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

struct SetupUserArrayModel: BaseModel {
    var users: [SetupUserModel]

    static func getRequestEvent() -> String {
        SocketEvents.IOS.SETUP.REQUEST_FOUNDRY_USERS
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.SETUP.SEND.SEND_FOUNDRY_USERS
    }
}

extension SocketEvents.IOS.SETUP {
    static let REQUEST_FOUNDRY_USERS = "ios:requestFoundryUsers"
}

extension SocketEvents.SERVER.SETUP.SEND {
    static let SEND_FOUNDRY_USERS = "server:sendFoundryUsers"
}

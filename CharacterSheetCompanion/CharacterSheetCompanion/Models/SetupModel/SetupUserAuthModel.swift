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
        REQUEST_EVENTS.SETUP.WORLD_USER_AUTH
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.SETUP.WORLD_USER_AUTH
    }
}

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
        REQUEST_EVENTS.SETUP.WORLD_USERS
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.SETUP.WORLD_USERS
    }
}

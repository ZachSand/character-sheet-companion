//
//  ActorClassArrayModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

struct ActorClassArrayModel: BaseModel {
    var classes: [ActorClassModel]

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ACTOR.CLASSES
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.CLASSES
    }
}

//
//  ActorBaseData.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

struct ActorBaseDataModel: Codable, Identifiable, Hashable, BaseModel {
    var id: String
    var name: String
    var image: Data?

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ACTOR.BASE_DATA
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.BASE_DATA
    }
}

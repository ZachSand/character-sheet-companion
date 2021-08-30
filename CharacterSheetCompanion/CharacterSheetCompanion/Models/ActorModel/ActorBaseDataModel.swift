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
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_BASE_DATA
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_BASE_DATA
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_BASE_DATA = "ios:requestActorBaseData"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_BASE_DATA = "server:sendActorBaseData"
}

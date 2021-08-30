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
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_CLASSES
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_CLASSES
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_CLASSES = "ios:requestActorClasses"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_CLASSES = "server:sendActorClasses"
}

//
//  ActorSpellArrayModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

struct ActorSpellArrayModel: BaseModel {
    var spells: [ActorSpellModel]

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SPELLS
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_SPELLS
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_SPELLS = "ios:requestActorSpells"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_SPELLS = "server:sendActorSpells"
}

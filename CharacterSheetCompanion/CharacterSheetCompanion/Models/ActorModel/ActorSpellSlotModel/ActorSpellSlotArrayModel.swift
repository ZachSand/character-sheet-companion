//
//  ActorSpellSlotArrayModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

struct ActorSpellSlotArrayModel: BaseModel {
    var spellSlots: [ActorSpellSlotModel]

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SPELL_SLOTS
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_SPELL_SLOTS
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_SPELL_SLOTS = "ios:requestActorSpellSlots"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_SPELL_SLOTS = "server:sendActorSpellSlots"
}

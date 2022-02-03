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
        REQUEST_EVENTS.ACTOR.SPELL_SLOTS
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.SPELL_SLOTS
    }
}

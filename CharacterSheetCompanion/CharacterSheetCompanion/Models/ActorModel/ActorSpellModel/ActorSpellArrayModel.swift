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
        REQUEST_EVENTS.ACTOR.SPELLS
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.SPELLS
    }
}

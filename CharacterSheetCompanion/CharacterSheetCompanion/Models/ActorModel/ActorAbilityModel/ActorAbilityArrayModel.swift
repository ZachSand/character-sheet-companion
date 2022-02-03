//
//  ActorAbilityArrayModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

struct ActorAbilityModelArray: BaseModel {
    var abilities: [ActorAbilityModel]

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ACTOR.ABILITIES
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.ABILITIES
    }
}

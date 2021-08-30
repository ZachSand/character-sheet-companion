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
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_ABILITIES
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_ABILITIES
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_ABILITIES = "ios:requestActorAbilities"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_ABILITIES = "server:sendActorAbilities"
}

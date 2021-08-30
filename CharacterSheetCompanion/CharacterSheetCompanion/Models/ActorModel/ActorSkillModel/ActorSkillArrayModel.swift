//
//  ActorSkillArrayModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

struct ActorSkillArrayModel: BaseModel {
    var skills: [ActorSkillModel]

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SKILLS
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_SKILLS
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_SKILLS = "ios:requestActorSkills"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_SKILLS = "server:sendActorSkills"
}

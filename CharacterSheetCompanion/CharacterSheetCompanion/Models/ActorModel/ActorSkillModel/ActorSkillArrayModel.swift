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
        REQUEST_EVENTS.ACTOR.SKILLS
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.SKILLS
    }
}

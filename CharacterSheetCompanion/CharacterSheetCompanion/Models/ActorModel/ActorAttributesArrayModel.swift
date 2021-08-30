//
//  ActorAttributesArrayModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

struct ActorAttributesArrayModel: BaseModel {
    var attributes: [ActorAttributesModel]

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_ATTRIBUTES
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_ATTRIBUTES
    }
}

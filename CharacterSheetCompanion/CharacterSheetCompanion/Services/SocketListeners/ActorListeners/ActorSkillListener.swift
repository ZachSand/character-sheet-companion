//
//  ActorSkillListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation
import SocketIO

class ActorSkillListener: SocketListener {
    let socket: SocketIOClient

    var actorSkillsCallback: (([ActorSkillModel]?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_SKILLS) { data, _ in
            do {
                try self.actorSkillsCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getActorSkills(actorId: String, completionHandler: @escaping ([ActorSkillModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SKILLS, actorId)
        actorSkillsCallback = completionHandler
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_SKILLS = "ios:requestActorSkills"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_SKILLS = "server:sendActorSkills"
}

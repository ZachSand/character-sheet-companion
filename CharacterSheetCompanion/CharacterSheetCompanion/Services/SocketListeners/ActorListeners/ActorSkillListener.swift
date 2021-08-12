//
//  ActorSkillListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Combine
import Foundation
import SocketIO

class ActorSkillListener: SocketListener, ActorListener, ObservableObject {
    let skillsPublisher: AnyPublisher<[ActorSkillModel]?, Never>
    let socket: SocketIOClient

    private let skillsSubject = CurrentValueSubject<[ActorSkillModel]?, Never>(nil)

    init(socket: SocketIOClient) {
        skillsPublisher = skillsSubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_SKILLS) { data, _ in
            do {
                try self.skillsSubject.send(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SKILLS, actorId)
    }

    func isReady() -> Bool {
        true
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_SKILLS = "ios:requestActorSkills"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_SKILLS = "server:sendActorSkills"
}

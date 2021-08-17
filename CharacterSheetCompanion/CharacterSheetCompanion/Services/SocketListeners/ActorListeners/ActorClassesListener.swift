//
//  ActorBaseDataListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Combine
import Foundation
import SocketIO

class ActorClassesListener: SocketListener, ActorListener {
    let classesPublisher: AnyPublisher<[ActorClassModel]?, Never>
    let socket: SocketIOClient

    private let classesSubject = CurrentValueSubject<[ActorClassModel]?, Never>(nil)

    init(socket: SocketIOClient) {
        classesPublisher = classesSubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_CLASSES) { data, _ in
            do {
                try self.classesSubject.send(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_CLASSES, actorId)
    }

    func isReady() -> Bool {
        true
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_CLASSES = "ios:requestActorClasses"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_CLASSES = "server:sendActorClasses"
}

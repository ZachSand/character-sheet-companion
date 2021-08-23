//
//  ActorOverviewListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Combine
import Foundation
import SocketIO

class ActorAttributesListener: SocketListener, ActorListener {
    let attributesPublisher: AnyPublisher<ActorAttributesModel?, Never>
    let socket: SocketIOClient

    private var receivedFirstMessage = false
    private let attributesSubject = CurrentValueSubject<ActorAttributesModel?, Never>(nil)

    init(socket: SocketIOClient) {
        attributesPublisher = attributesSubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_ATTRIBUTES) { data, _ in
            do {
                try self.attributesSubject.send(SocketListenerUtility.parseSocketEventData(data))
                self.receivedFirstMessage = true
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestActorHealthChange(actorId: String, healthChange: Int) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_HEALTH_CHANGE, actorId, healthChange)
    }

    func requestActorShortRest(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SHORT_REST, actorId)
    }

    func requestActorLongRest(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_LONG_REST, actorId)
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_ATTRIBUTES, actorId)
    }

    func isReady() -> Bool {
        receivedFirstMessage
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_ATTRIBUTES = "ios:requestActorAttributes"
    static let REQUEST_ACTOR_HEALTH_CHANGE = "ios:requestActorHealthChange"
    static let REQUEST_ACTOR_SHORT_REST = "ios:requestActorShortRest"
    static let REQUEST_ACTOR_LONG_REST = "ios:requestActorLongRest"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_ATTRIBUTES = "server:sendActorAttributes"
}

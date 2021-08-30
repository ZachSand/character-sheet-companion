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

    func requestActorHealthChange(healthChange: Int) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_HEALTH_CHANGE, actor.id, healthChange)
        }
    }

    func requestActorShortRest() {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SHORT_REST, actor.id)
        }
    }

    func requestActorLongRest() {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_LONG_REST, actor.id)
        }
    }

    func requestInitialActorData() {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_ATTRIBUTES, actor.id)
        }
    }

    func isReady() -> Bool {
        receivedFirstMessage
    }
}

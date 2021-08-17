//
//  ActorBaseDataListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Combine
import Foundation
import SocketIO

class ActorTraitsListener: SocketListener, ActorListener {
    let traitsPublisher: AnyPublisher<ActorTraitsModel?, Never>
    let socket: SocketIOClient

    private let traitsSubject = CurrentValueSubject<ActorTraitsModel?, Never>(nil)

    init(socket: SocketIOClient) {
        traitsPublisher = traitsSubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_TRAITS) { data, _ in
            do {
                try self.traitsSubject.send(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_TRAITS, actorId)
    }

    func isReady() -> Bool {
        true
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_TRAITS = "ios:requestActorTraits"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_TRAITS = "server:sendActorTraits"
}

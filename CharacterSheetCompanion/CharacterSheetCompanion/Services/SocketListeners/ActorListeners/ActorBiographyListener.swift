//
//  ActorBiographyListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Combine
import Foundation
import SocketIO

class ActorBiographyListener: SocketListener, ActorListener {
    let biographyPublisher: AnyPublisher<ActorBiographyModel?, Never>
    let socket: SocketIOClient

    private let biographySubject = CurrentValueSubject<ActorBiographyModel?, Never>(nil)

    init(socket: SocketIOClient) {
        self.socket = socket
        biographyPublisher = biographySubject.eraseToAnyPublisher()
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_BIOGRAPHY) { data, _ in
            do {
                try self.biographySubject.send(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_BIOGRAPHY, actorId)
    }

    func isReady() -> Bool {
        true
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_BIOGRAPHY = "ios:requestActorBiography"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_BIOGRAPHY = "server:sendActorBiography"
}

//
//  ActorBiographyListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Combine
import Foundation
import SocketIO

class ActorDetailsListener: SocketListener, ActorListener {
    let detailsPublisher: AnyPublisher<ActorDetailsModel?, Never>
    let socket: SocketIOClient

    private let detailsSubject = CurrentValueSubject<ActorDetailsModel?, Never>(nil)

    init(socket: SocketIOClient) {
        self.socket = socket
        detailsPublisher = detailsSubject.eraseToAnyPublisher()
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_DETAILS) { data, _ in
            do {
                try self.detailsSubject.send(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_DETAILS, actorId)
    }

    func isReady() -> Bool {
        true
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_DETAILS = "ios:requestActorDetails"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_DETAILS = "server:sendActorDetails"
}

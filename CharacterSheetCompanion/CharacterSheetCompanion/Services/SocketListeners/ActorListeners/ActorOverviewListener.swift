//
//  ActorOverviewListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Combine
import Foundation
import SocketIO

class ActorOverviewListener: SocketListener, ActorListener {
    let overviewPublisher: AnyPublisher<ActorOverviewModel?, Never>
    let socket: SocketIOClient

    private let overviewSubject = CurrentValueSubject<ActorOverviewModel?, Never>(nil)

    init(socket: SocketIOClient) {
        overviewPublisher = overviewSubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_OVERVIEW) { data, _ in
            do {
                try self.overviewSubject.send(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_OVERVIEW, actorId)
    }

    func isReady() -> Bool {
        true
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_OVERVIEW = "ios:requestActorOverview"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_OVERVIEW = "server:sendActorOverview"
}

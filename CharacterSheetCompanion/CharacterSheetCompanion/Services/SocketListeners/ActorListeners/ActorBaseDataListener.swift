//
//  ActorBaseDataListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Combine
import Foundation
import SocketIO

class ActorBaseDataListener: SocketListener, ActorListener {
    let baseDataPublisher: AnyPublisher<ActorBaseDataModel?, Never>
    let socket: SocketIOClient

    private let baseDataSubject = CurrentValueSubject<ActorBaseDataModel?, Never>(nil)

    init(socket: SocketIOClient) {
        baseDataPublisher = baseDataSubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_BASE_DATA) { data, _ in
            do {
                try self.baseDataSubject.send(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_BASE_DATA, actorId)
    }

    func isReady() -> Bool {
        true
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_BASE_DATA = "ios:requestActorBaseData"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_BASE_DATA = "server:sendActorBaseData"
}

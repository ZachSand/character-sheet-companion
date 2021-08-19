//
//  ActorSpellListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/13/21.
//

import Combine
import Foundation
import SocketIO

class ActorSpellListener: SocketListener, ActorListener {
    let spellsPublisher: AnyPublisher<[ActorSpellModel]?, Never>
    let socket: SocketIOClient

    private var receivedFirstMessage = false
    private let spellsSubject = CurrentValueSubject<[ActorSpellModel]?, Never>(nil)

    init(socket: SocketIOClient) {
        spellsPublisher = spellsSubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_SPELLS) { data, _ in
            do {
                try self.spellsSubject.send(SocketListenerUtility.parseSocketEventDataArray(data))
                self.receivedFirstMessage = true
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SPELLS, actorId)
    }

    func isReady() -> Bool {
        receivedFirstMessage
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_SPELLS = "ios:requestActorSpells"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_SPELLS = "server:sendActorSpells"
}

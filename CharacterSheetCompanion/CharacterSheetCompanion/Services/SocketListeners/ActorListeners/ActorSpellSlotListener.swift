//
//  ActorSpellSlotListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Combine
import Foundation
import SocketIO

class ActorSpellSlotListener: SocketListener, ActorListener {
    let spellSlotPublisher: AnyPublisher<[ActorSpellSlotModel]?, Never>
    let socket: SocketIOClient

    private var receivedFirstMessage = false
    private let spellSlotSubject = CurrentValueSubject<[ActorSpellSlotModel]?, Never>(nil)

    init(socket: SocketIOClient) {
        spellSlotPublisher = spellSlotSubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_SPELL_SLOTS) { data, _ in
            do {
                try self.spellSlotSubject.send(SocketListenerUtility.parseSocketEventDataArray(data))
                self.receivedFirstMessage = true
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SPELL_SLOTS, actorId)
    }

    func isReady() -> Bool {
        receivedFirstMessage
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_SPELL_SLOTS = "ios:requestActorSpellSlots"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_SPELL_SLOTS = "server:sendActorSpellSlots"
}

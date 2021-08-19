//
//  ActorAbilityListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Combine
import Foundation
import SocketIO

class ActorAbilityListener: SocketListener, ActorListener {
    let socket: SocketIOClient
    let abilitiesPublisher: AnyPublisher<[ActorAbilityModel]?, Never>

    private var receivedFirstMessage = false
    private let abilitySubject = CurrentValueSubject<[ActorAbilityModel]?, Never>(nil)

    init(socket: SocketIOClient) {
        self.socket = socket
        abilitiesPublisher = abilitySubject.eraseToAnyPublisher()
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_ABILITIES) { data, _ in
            do {
                self.abilitySubject.send(try SocketListenerUtility.parseSocketEventDataArray(data))
                self.receivedFirstMessage = true
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_ABILITIES, actorId)
    }

    func isReady() -> Bool {
        receivedFirstMessage
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_ABILITIES = "ios:requestActorAbilities"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_ABILITIES = "server:sendActorAbilities"
}

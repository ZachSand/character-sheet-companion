//
//  ActorInventoryListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Combine
import Foundation
import SocketIO

class ActorInventoryListener: SocketListener, ActorListener {
    let inventoryPublisher: AnyPublisher<ActorInventoryModel?, Never>
    let socket: SocketIOClient

    private let inventorySubject = CurrentValueSubject<ActorInventoryModel?, Never>(nil)

    init(socket: SocketIOClient) {
        inventoryPublisher = inventorySubject.eraseToAnyPublisher()
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_INVENTORY) { data, _ in
            do {
                try self.inventorySubject.send(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData(actorId: String) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_INVENTORY, actorId)
    }

    func isReady() -> Bool {
        true
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_INVENTORY = "ios:requestActorInventory"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_INVENTORY = "server:sendActorInventory"
}

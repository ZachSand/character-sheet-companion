//
//  ActorInventoryListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation
import SocketIO

class ActorInventoryListener: SocketListener {
    let socket: SocketIOClient

    var actorInventoryCallback: ((ActorInventoryModel?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_INVENTORY) { data, _ in
            do {
                try self.actorInventoryCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getActorInventory(actorId: String, completionHandler: @escaping (ActorInventoryModel?) -> Void) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_INVENTORY, actorId)
        actorInventoryCallback = completionHandler
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_INVENTORY = "ios:requestActorInventory"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_INVENTORY = "server:sendActorInventory"
}

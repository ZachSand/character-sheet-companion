//
//  ActorListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class ActorDataListener: SocketListener {
    let socket: SocketIOClient

    var actorCallback: ((ActorDataModel?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ACTOR_DATA) { data, _ in
            do {
                try self.actorCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getActorData(actorId: String, completionHandler: @escaping (ActorDataModel?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ACTOR_DATA, actorId)
        actorCallback = completionHandler
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_ACTOR_DATA = "ios:requestFoundryActorData"
}

extension SocketEvents.SERVER {
    static let SEND_FOUNDRY_ACTOR_DATA = "server:sendFoundryActorData"
}

extension ListenerEvents {
    static let ACTOR_DATA = "ACTOR_DATA"
}

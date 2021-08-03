//
//  ActorListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class ActorListener: SocketListener {
    let socket: SocketIOClient
    
    var actorCallback: ((ActorModel?)->Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }
    
    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ACTOR_DATA) {data, ack in
            do {
                try self.actorCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }
    
    func getActorData(actorId: String, completionHandler: @escaping (ActorModel?) -> Void) {
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

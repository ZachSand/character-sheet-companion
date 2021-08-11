//
//  ActorBiographyListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation
import SocketIO

class ActorBiographyListener: SocketListener {
    let socket: SocketIOClient

    var actorBiographyCallback: ((ActorBiographyModel?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_BIOGRAPHY) { data, _ in
            do {
                try self.actorBiographyCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getActorBiography(actorId: String, completionHandler: @escaping (ActorBiographyModel?) -> Void) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_BIOGRAPHY, actorId)
        actorBiographyCallback = completionHandler
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_BIOGRAPHY = "ios:requestActorBiography"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_BIOGRAPHY = "server:sendActorBiography"
}

//
//  UserActorListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class UserActorListener: SocketListener {
    let socket: SocketIOClient

    var userActorsCallback: (([UserActorModel]?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_USER_ACTORS) { data, _ in
            do {
                try self.userActorsCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getUserActors(completionHandler: @escaping ([UserActorModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_USER_ACTORS)
        userActorsCallback = completionHandler
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_USER_ACTORS = "ios:requestFoundryUserActor"
}

extension SocketEvents.SERVER {
    static let SEND_FOUNDRY_USER_ACTORS = "server:sendFoundryUserActor"
}

extension ListenerEvents {
    static let USER_ACTORS = "USER_ACTORS"
}

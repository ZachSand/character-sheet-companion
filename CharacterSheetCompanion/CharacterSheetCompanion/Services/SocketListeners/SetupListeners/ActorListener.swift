//
//  UserActorListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class ActorListener: SocketListener {
    let socket: SocketIOClient

    var actorsCallback: (([ActorModel]?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SETUP.SEND.SEND_FOUNDRY_ACTORS) { data, _ in
            do {
                try self.actorsCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getActors(completionHandler: @escaping ([ActorModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.SETUP.REQUEST_FOUNDRY_ACTORS)
        actorsCallback = completionHandler
    }
}

extension SocketEvents.IOS.SETUP {
    static let REQUEST_FOUNDRY_ACTORS = "ios:requestFoundryActors"
}

extension SocketEvents.SERVER.SETUP.SEND {
    static let SEND_FOUNDRY_ACTORS = "server:sendFoundryActors"
}

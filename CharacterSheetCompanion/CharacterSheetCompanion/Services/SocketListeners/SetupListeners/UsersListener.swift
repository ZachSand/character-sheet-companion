//
//  UsersListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class UsersListener: SocketListener {
    let socket: SocketIOClient

    var usersCallback: (([UserModel]?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SETUP.SEND.SEND_FOUNDRY_USERS) { data, _ in
            do {
                try self.usersCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getUsers(completionHandler: @escaping ([UserModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.SETUP.REQUEST_FOUNDRY_USERS)
        usersCallback = completionHandler
    }
}

extension SocketEvents.IOS.SETUP {
    static let REQUEST_FOUNDRY_USERS = "ios:requestFoundryUsers"
}

extension SocketEvents.SERVER.SETUP.SEND {
    static let SEND_FOUNDRY_USERS = "server:sendFoundryUsers"
}

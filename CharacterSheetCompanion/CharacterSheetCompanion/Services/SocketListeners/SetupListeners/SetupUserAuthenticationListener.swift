//
//  SetupUserAuthenticationListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation
import SocketIO

class SetupUserAuthenticationListener: SocketListener {
    let socket: SocketIOClient

    private var userAuthCallback: ((Bool) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SETUP.SEND.SEND_FOUNDRY_USER_AUTH) { data, _ in
            do {
                try self.userAuthCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func userLogin(user: SetupUserModel, password: String, completionHandler: @escaping (Bool) -> Void) {
        socket.emit(SocketEvents.IOS.SETUP.REQUEST_USER_AUTH, user.id, password)
        userAuthCallback = completionHandler
    }
}

extension SocketEvents.IOS.SETUP {
    static let REQUEST_USER_AUTH = "ios:requestFoundryUserAuthentication"
}

extension SocketEvents.SERVER.SETUP.SEND {
    static let SEND_FOUNDRY_USER_AUTH = "server:sendFoundryUserAuthentication"
}

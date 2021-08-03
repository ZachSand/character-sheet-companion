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
    
    var usersCallback: (([UserModel]?)->Void)?
    
    init(socket: SocketIOClient) {
        self.socket = socket
    }
    
    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_USERS) {data, ack in
            do {
                try self.usersCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }
    
    func getUsers(completionHandler: @escaping ([UserModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_USERS)
        usersCallback = completionHandler
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_USERS = "ios:requestFoundryUsers"
}

extension SocketEvents.SERVER {
    static let SEND_FOUNDRY_USERS = "server:sendFoundryUsers"
}

extension ListenerEvents {
     static let USERS = "USERS"
}

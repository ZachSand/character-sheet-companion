//
//  SocketConnectionListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class ConnectionListener: SocketListener {
    let socket: SocketIOClient

    var socketConnectionCallback: ((Bool) -> Void)?
    var roomId: String?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(clientEvent: .connect) { _, _ in
            if let socketRoomId = self.roomId {
                self.socket.emit(SocketEvents.IOS.SETUP.JOIN_ROOM, socketRoomId)
            }
        }

        socket.on(SocketEvents.SERVER.SETUP.SEND.SEND_IOS_JOINED_ROOM) { _, _ in
            self.socketConnectionCallback?(true)
        }
    }

    func socketConnect(completionHandler: @escaping (Bool) -> Void) {
        socket.connect()
        socketConnectionCallback = completionHandler
    }
}

extension SocketEvents.IOS.SETUP {
    static let JOIN_ROOM = "ios:joinRoom"
}

extension SocketEvents.SERVER.SETUP.SEND {
    static let SEND_IOS_JOINED_ROOM = "server:sendIosJoinedRoom"
}

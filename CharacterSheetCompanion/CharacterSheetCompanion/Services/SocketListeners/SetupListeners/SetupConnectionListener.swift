//
//  SocketConnectionListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class SetupConnectionListener: SocketListener {
    let socket: SocketIOClient

    private var socketConnectionCallback: ((Bool) -> Void)?
    var socketRoomId: String?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SETUP.SEND.SEND_IOS_JOINED_ROOM) { _, _ in
            self.socketConnectionCallback?(true)
        }
    }

    func joinSocketRoom(socketRoomId: String, completionHandler: @escaping (Bool) -> Void) {
        self.socketRoomId = socketRoomId
        socketConnectionCallback = completionHandler
        socket.emit(SocketEvents.IOS.SETUP.JOIN_ROOM, socketRoomId)
    }
}

extension SocketEvents.IOS.SETUP {
    static let JOIN_ROOM = "ios:joinRoom"
}

extension SocketEvents.SERVER.SETUP.SEND {
    static let SEND_IOS_JOINED_ROOM = "server:sendIosJoinedRoom"
}

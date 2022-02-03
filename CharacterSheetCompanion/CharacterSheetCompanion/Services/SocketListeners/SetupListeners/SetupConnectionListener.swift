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
        socket.on(RECEIVE_EVENTS.SETUP.JOIN_ROOM) { _, _ in
            self.socketConnectionCallback?(true)
        }
    }

    func joinSocketRoom(socketRoomId: String, completionHandler: @escaping (Bool) -> Void) {
        self.socketRoomId = socketRoomId
        socketConnectionCallback = completionHandler
        socket.emit(REQUEST_EVENTS.SETUP.JOIN_ROOM, socketRoomId)
    }
}

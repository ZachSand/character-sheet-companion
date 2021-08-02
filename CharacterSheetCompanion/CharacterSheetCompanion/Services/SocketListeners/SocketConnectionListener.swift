//
//  SocketConnectionListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class SocketConnectionListener: SocketListener {
    var socket: SocketIOClient
    var socketConnectionCallback: ((Bool)->Void)?
    var roomId: String?
    
    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func socketConnect(completionHandler: @escaping (Bool) -> Void) {
        socket.connect()
        socketConnectionCallback = completionHandler
    }
    
    func addSocketHandlers() {
        socket.on(clientEvent: .connect) {data, ack in
            if let socketRoomId = self.roomId {
                self.socket.emit(SocketEvents.IOS.JOIN_ROOM, socketRoomId)
            }
        }
    }
}


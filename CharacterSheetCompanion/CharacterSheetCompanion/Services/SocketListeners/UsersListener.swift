//
//  UsersListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class UsersListener {
    var socket: SocketIOClient
    init(socket: SocketIOClient) {
        self.socket = socket
    }
}

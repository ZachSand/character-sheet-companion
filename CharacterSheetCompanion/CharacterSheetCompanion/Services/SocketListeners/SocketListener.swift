//
//  SocketListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

protocol SocketListener {
    var socket: SocketIOClient {get set}
    func addSocketHandlers()
}

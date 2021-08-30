//
//  ListenerWrapper.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation
import SocketIO

protocol ListenerWrapper {
    var socketListeners: [SocketListener] { get }
    var socket: SocketIOClient { get }
}

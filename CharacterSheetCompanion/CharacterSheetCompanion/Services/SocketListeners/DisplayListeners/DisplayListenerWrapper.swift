//
//  DisplayListenerWrapper.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation
import SocketIO

struct DisplayListenerWrapper: ListenerWrapper {
    var socketListeners: [SocketListener]
    var socket: SocketIOClient

    let displayItemListener: DisplayItemListener
    let displayChatMessageListener: DisplayChatMessageListener

    init(socket: SocketIOClient) {
        self.socket = socket

        displayItemListener = DisplayItemListener(socket: socket)
        displayChatMessageListener = DisplayChatMessageListener(socket: socket)

        socketListeners = [
            displayItemListener,
            displayChatMessageListener,
        ]
    }
}

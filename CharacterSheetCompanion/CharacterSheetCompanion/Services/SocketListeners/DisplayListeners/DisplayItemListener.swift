//
//  ItemDisplayListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import Foundation
import SocketIO

class DisplayItemListener: SocketListener {
    let socket: SocketIOClient

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        // No Listener for item display
    }

    func displayItemCard(itemId: String) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(REQUEST_EVENTS.DISPLAY.ITEM, actor.id, itemId)
        }
    }
}

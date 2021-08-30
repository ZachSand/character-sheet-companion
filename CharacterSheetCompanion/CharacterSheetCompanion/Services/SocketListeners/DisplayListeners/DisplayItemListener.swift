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

    private let jsonEncoder = JSONEncoder()

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        // No Listener for item display
    }

    func displayItemCard(itemId: String) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(SocketEvents.IOS.DISPLAY.REQUEST_FOUNDRY_DISPLAY_ITEM, actor.id, itemId)
        }
    }
}

extension SocketEvents.IOS.DISPLAY {
    static let REQUEST_FOUNDRY_DISPLAY_ITEM = "ios:requestFoundryDisplayItem"
}

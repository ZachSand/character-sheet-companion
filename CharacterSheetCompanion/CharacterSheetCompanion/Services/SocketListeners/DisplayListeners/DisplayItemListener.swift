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

    func displayItemCard(displayItem: ItemDisplayModel) {
        do {
            let jsonData = try jsonEncoder.encode(displayItem)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.DISPLAY.REQUEST_FOUNDRY_DISPLAY_ITEM, json)
            }
        } catch {}
    }
}

extension SocketEvents.IOS.DISPLAY {
    static let REQUEST_FOUNDRY_DISPLAY_ITEM = "ios:requestFoundryDisplayItem"
}

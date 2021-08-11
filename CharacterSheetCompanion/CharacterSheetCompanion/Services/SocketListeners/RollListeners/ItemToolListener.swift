//
//  ItemToolListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class ItemToolListener: SocketListener {
    let socket: SocketIOClient
    let jsonEncoder: JSONEncoder

    var itemToolRollCallback: ((ItemToolRollModel?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
        jsonEncoder = JSONEncoder()
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_TOOL_ROLL) { data, _ in
            do {
                try self.itemToolRollCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func rollItemTool(itemToolRoll: ItemToolRollModel, completionHandler: @escaping (ItemToolRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(itemToolRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_ITEM_TOOL_ROLL, json)
                itemToolRollCallback = completionHandler
            }
        } catch {}
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_ITEM_TOOL_ROLL = "ios:requestFoundryItemToolRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_ITEM_TOOL_ROLL = "server:sendFoundryItemToolRoll"
}

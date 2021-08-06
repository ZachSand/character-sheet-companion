//
//  ItemConsumeListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class ItemConsumeListener: SocketListener {
    let socket: SocketIOClient
    let jsonEncoder: JSONEncoder

    var itemConsumeRollCallback: ((ItemConsumeRollModel?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
        jsonEncoder = JSONEncoder()
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ITEM_CONSUME_ROLL) { data, _ in
            do {
                try self.itemConsumeRollCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func rollItemConsume(itemConsumeRoll: ItemConsumeRollModel, completionHandler: @escaping (ItemConsumeRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(itemConsumeRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL, json)
                itemConsumeRollCallback = completionHandler
            }
        } catch {}
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_ITEM_CONSUME_ROLL = "ios:requestFoundryItemConsumeRoll"
}

extension SocketEvents.SERVER {
    static let SEND_FOUNDRY_ITEM_CONSUME_ROLL = "server:sendFoundryItemConsumeRoll"
}

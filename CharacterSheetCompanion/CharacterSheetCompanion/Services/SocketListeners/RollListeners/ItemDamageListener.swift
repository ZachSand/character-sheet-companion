//
//  ItemDamageListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class ItemDamageListener: SocketListener {
    let socket: SocketIOClient
    let jsonEncoder: JSONEncoder
    
    var itemDamageRollCallback: ((ItemDamageRollModel?)->Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
        jsonEncoder = JSONEncoder()
    }
    
    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ITEM_DAMAGE_ROLL) {data, ack in
            do {
                try self.itemDamageRollCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }
    
    func rollItemDamage(damageRoll: ItemDamageRollModel, completionHandler: @escaping (ItemDamageRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(damageRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL, json)
                itemDamageRollCallback = completionHandler
            }
        } catch {
            
        }
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL = "ios:requestFoundryItemDamageRoll"
}

extension SocketEvents.SERVER {
    static let SEND_FOUNDRY_ITEM_DAMAGE_ROLL = "server:sendFoundryItemDamageRoll"
}

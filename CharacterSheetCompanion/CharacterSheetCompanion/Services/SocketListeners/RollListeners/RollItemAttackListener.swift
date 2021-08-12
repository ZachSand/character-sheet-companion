//
//  ItemAttackListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class RollItemAttackListener: SocketListener {
    let socket: SocketIOClient
    let jsonEncoder: JSONEncoder

    var itemAttackRollCallback: ((ItemAttackRollModel) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
        jsonEncoder = JSONEncoder()
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_ITEM_ATTACK_ROLL) { data, _ in
            do {
                try self.itemAttackRollCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func rollItemAttack(attackRoll: ItemAttackRollModel, completionHandler: @escaping (ItemAttackRollModel) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(attackRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_ITEM_ATTACK_ROLL, json)
                itemAttackRollCallback = completionHandler
            }
        } catch {}
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_ITEM_ATTACK_ROLL = "ios:requestFoundryItemAttackRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_ITEM_ATTACK_ROLL = "server:sendFoundryItemAttackRoll"
}
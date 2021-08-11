//
//  AbilityListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class AbilityListener: SocketListener {
    let socket: SocketIOClient
    let jsonEncoder: JSONEncoder

    var abilityRollCallback: ((AbilityRollModel?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
        jsonEncoder = JSONEncoder()
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_ABILITY_ROLL) { data, _ in
            do {
                try self.abilityRollCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func rollAbility(abilityRoll: AbilityRollModel, completionHandler: @escaping (AbilityRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(abilityRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_ABILITY_ROLL, json)
                abilityRollCallback = completionHandler
            }
        } catch {}
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_ABILITY_ROLL = "ios:requestFoundryAbilityRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_ABILITY_ROLL = "server:sendFoundryAbilityRoll"
}

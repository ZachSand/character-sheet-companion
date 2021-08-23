//
//  InitiativeListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class RollHitDieListener: SocketListener {
    let socket: SocketIOClient

    private let jsonEncoder = JSONEncoder()
    private var hitDieCallback: ((HitDieRollModel) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ROLL.SEND.SEND_HIT_DIE_ROLL) { data, _ in
            do {
                try self.hitDieCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func rollHitDie(hitDieRoll: HitDieRollModel, completionHandler: @escaping (HitDieRollModel) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(hitDieRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_HIT_DIE_ROLL, json)
                hitDieCallback = completionHandler
            }
        } catch {}
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_HIT_DIE_ROLL = "ios:requestFoundryHitDieRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_HIT_DIE_ROLL = "foundry:sendHitDieRoll"
}

//
//  InitiativeListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class RollDeathSaveListener: SocketListener {
    let socket: SocketIOClient

    private let jsonEncoder = JSONEncoder()
    private var deathSaveRollCallback: ((DeathSaveRollModel) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ROLL.SEND.SEND_DEATH_SAVE_ROLL) { data, _ in
            do {
                try self.deathSaveRollCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func rollDeathSave(deathSaveRoll: DeathSaveRollModel, completionHandler: @escaping (DeathSaveRollModel) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(deathSaveRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_DEATH_SAVE_ROLL, json)
                deathSaveRollCallback = completionHandler
            }
        } catch {}
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_DEATH_SAVE_ROLL = "ios:requestFoundryDeathSaveRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_DEATH_SAVE_ROLL = "foundry:sendDeathSaveRoll"
}

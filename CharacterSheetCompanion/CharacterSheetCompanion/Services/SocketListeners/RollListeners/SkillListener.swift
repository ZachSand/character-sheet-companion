//
//  SkillListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class SkillListener: SocketListener {
    let socket: SocketIOClient
    let jsonEncoder: JSONEncoder

    var skillRollCallback: ((SkillRollModel?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
        jsonEncoder = JSONEncoder()
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ROLL.SEND.SEND_FOUNDRY_SKILL_ROLL) { data, _ in
            do {
                try self.skillRollCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func rollSkill(skillRoll: SkillRollModel, completionHandler: @escaping (SkillRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(skillRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.ROLL.REQUEST_FOUNDRY_SKILL_ROLL, json)
                skillRollCallback = completionHandler
            }
        } catch {}
    }
}

extension SocketEvents.IOS.ROLL {
    static let REQUEST_FOUNDRY_SKILL_ROLL = "ios:requestFoundrySkillRoll"
}

extension SocketEvents.SERVER.ROLL.SEND {
    static let SEND_FOUNDRY_SKILL_ROLL = "server:sendFoundrySkillRoll"
}

//
//  InitiativeListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class InitiativeListener: SocketListener {
    let socket: SocketIOClient
    let jsonEncoder: JSONEncoder
    
    var initiativeRollCallback: ((InitiativeRollModel?)->Void)?
    
    init(socket: SocketIOClient) {
        self.socket = socket
        jsonEncoder = JSONEncoder()
    }
    
    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_INITIATIVE_ROLL) {data, ack in
            do {
                try self.initiativeRollCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }
    
    func rollInitiative(initiativeRoll: InitiativeRollModel, completionHandler: @escaping (InitiativeRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(initiativeRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_INITIATIVE_ROLL, json)
                initiativeRollCallback = completionHandler
            }
        } catch {
            
        }
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_INITIATIVE_ROLL = "ios:requestFoundryInitiativeRoll"
}

extension SocketEvents.SERVER {
    static let SEND_INITIATIVE_ROLL = "foundry:sendInitiativeRoll"
}

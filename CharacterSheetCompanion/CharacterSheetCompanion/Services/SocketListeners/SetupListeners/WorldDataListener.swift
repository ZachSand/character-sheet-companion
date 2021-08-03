//
//  WorldDataListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class WorldDataListener: SocketListener {
    let socket: SocketIOClient
    
    var worldDataCallback: ((WorldDataModel?)->Void)?
    
    init(socket: SocketIOClient) {
        self.socket = socket
    }
    
    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_WORLD_DATA) {data, ack in
            do {
                try self.worldDataCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }
    
    func getWorldData(completionHandler: @escaping (WorldDataModel?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_WORLD_DATA)
        worldDataCallback = completionHandler
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_WORLD_DATA = "ios:requestFoundryWorldData"
}

extension SocketEvents.SERVER {
    static let SEND_FOUNDRY_WORLD_DATA = "server:sendFoundryWorldData"
}

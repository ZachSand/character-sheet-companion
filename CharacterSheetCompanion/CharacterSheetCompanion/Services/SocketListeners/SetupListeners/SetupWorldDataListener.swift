//
//  WorldDataListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import Foundation
import SocketIO

class SetupWorldDataListener: SocketListener {
    let socket: SocketIOClient

    private var worldDataCallback: ((WorldDataModel) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SETUP.SEND.SEND_FOUNDRY_WORLD_DATA) { data, _ in
            do {
                try self.worldDataCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getWorldData(completionHandler: @escaping (WorldDataModel) -> Void) {
        socket.emit(SocketEvents.IOS.SETUP.REQUEST_FOUNDRY_WORLD_DATA)
        worldDataCallback = completionHandler
    }
}

extension SocketEvents.IOS.SETUP {
    static let REQUEST_FOUNDRY_WORLD_DATA = "ios:requestFoundryWorldData"
}

extension SocketEvents.SERVER.SETUP.SEND {
    static let SEND_FOUNDRY_WORLD_DATA = "server:sendFoundryWorldData"
}

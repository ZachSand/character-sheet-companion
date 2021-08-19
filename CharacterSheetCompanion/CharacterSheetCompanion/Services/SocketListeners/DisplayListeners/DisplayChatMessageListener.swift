//
//  ChatMessageListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import Foundation
import SocketIO

class DisplayChatMessageListener: SocketListener {
    let socket: SocketIOClient

    private var chatMessageCallback: (([ChatMessageModel]) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.DISPLAY.SEND.SEND_FOUNDRY_CHAT_DATA) { data, _ in
            do {
                try self.chatMessageCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getChatMessages(userId: String, actorId: String, completionHandler: @escaping ([ChatMessageModel]) -> Void) {
        socket.emit(SocketEvents.IOS.DISPLAY.REQUEST_FOUNDRY_CHAT_DATA, userId, actorId)
        chatMessageCallback = completionHandler
    }

    func sendChatMessage(userId: String, actorId: String, message: String) {
        socket.emit(SocketEvents.IOS.DISPLAY.SEND_FOUNDRY_CHAT_MESSAGE, userId, actorId, message)
    }
}

extension SocketEvents.IOS.DISPLAY {
    static let REQUEST_FOUNDRY_CHAT_DATA = "ios:requestFoundryChatData"
    static let SEND_FOUNDRY_CHAT_MESSAGE = "ios:sendFoundryChatMessage"
}

extension SocketEvents.SERVER.DISPLAY.SEND {
    static let SEND_FOUNDRY_CHAT_DATA = "server:sendFoundryChatData"
}

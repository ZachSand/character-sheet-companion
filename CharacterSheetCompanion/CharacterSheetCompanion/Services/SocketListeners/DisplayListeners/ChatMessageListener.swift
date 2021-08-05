//
//  ChatMessageListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import Foundation
import SocketIO

class ChatMessageListener: SocketListener {
    let socket: SocketIOClient
    
    var chatMessageCallback: (([ChatMessageModel]?)->Void)?
    
    init(socket: SocketIOClient) {
        self.socket = socket
    }
    
    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_CHAT_DATA) {data, ack in
            do {
                try self.chatMessageCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }
    
    func getChatMessages(userId: String, actorId: String, completionHandler: @escaping ([ChatMessageModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_CHAT_DATA, userId, actorId)
        chatMessageCallback = completionHandler
    }
    
    func sendChatMessage(userId: String, actorId: String, message: String) {
        socket.emit(SocketEvents.IOS.SEND_FOUNDRY_CHAT_MESSAGE, userId, actorId, message)
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_CHAT_DATA = "ios:requestFoundryChatData"
    static let SEND_FOUNDRY_CHAT_MESSAGE = "ios:sendFoundryChatMessage"
}

extension SocketEvents.SERVER {
    static let SEND_FOUNDRY_CHAT_DATA = "server:sendFoundryChatData"
}

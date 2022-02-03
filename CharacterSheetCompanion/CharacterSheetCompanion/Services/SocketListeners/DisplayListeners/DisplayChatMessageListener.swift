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
        socket.on(RECEIVE_EVENTS.DISPLAY.CHAT_DATA) { data, _ in
            do {
                try self.chatMessageCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getChatMessages(completionHandler: @escaping ([ChatMessageModel]) -> Void) {
        chatMessageCallback = completionHandler
        if let actor = SocketManagerWrapper.sharedInstance.actor, let user = SocketManagerWrapper.sharedInstance.user {
            socket.emit(REQUEST_EVENTS.DISPLAY.CHAT_DATA, user.id, actor.id)
        }
    }

    func sendChatMessage(message: String) {
        if let actor = SocketManagerWrapper.sharedInstance.actor, let user = SocketManagerWrapper.sharedInstance.user {
            socket.emit(REQUEST_EVENTS.DISPLAY.CHAT_MESSAGE, user.id, actor.id, message)
        }
    }
}

//
//  ChatViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessageModel]

    var displayChatMessageListener = SocketManagerWrapper.sharedInstance.displayListenerWrapper.displayChatMessageListener

    init(chatMessages: [ChatMessageModel]) {
        self.chatMessages = chatMessages
    }

    func getMessageData() {
        displayChatMessageListener.getChatMessages(completionHandler: { chatMessageModels in
            self.chatMessages = chatMessageModels
        })
    }

    func getDateForTime(epochTime: Double) -> String {
        let date = Date(timeIntervalSince1970: epochTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }

    func sendMessage(message: String) {
        displayChatMessageListener.sendChatMessage(message: message)
    }
}

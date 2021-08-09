//
//  ChatViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessageModel]
    let user: UserModel

    var chatMessageListener: ChatMessageListener?

    init(user: UserModel, chatMessages: [ChatMessageModel]) {
        self.user = user
        do {
            try chatMessageListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
        self.chatMessages = chatMessages
    }

    func getMessageData() {
        if let listener = chatMessageListener {
            DispatchQueue.main.async {
                listener.getChatMessages(userId: self.user.id, actorId: "", completionHandler: { chatMessageModels in
                    if let chatMessages = chatMessageModels {
                        self.chatMessages = chatMessages
                    }
                })
            }
        }
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
        if let listener = chatMessageListener {
            DispatchQueue.main.async {
                listener.sendChatMessage(userId: self.user.id, actorId: "", message: message)
            }
        }
    }
}

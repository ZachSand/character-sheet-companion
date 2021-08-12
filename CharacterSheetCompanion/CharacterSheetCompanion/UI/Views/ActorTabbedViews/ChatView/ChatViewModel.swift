//
//  ChatViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessageModel]

    var displayChatMessageListener: DisplayChatMessageListener?

    init(chatMessages: [ChatMessageModel]) {
        do {
            try displayChatMessageListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
        self.chatMessages = chatMessages
    }

    func getMessageData() {
        if let listener = displayChatMessageListener, let actor = FoundrySocketIOManager.sharedInstance.actor, let user = FoundrySocketIOManager.sharedInstance.user {
            DispatchQueue.main.async {
                listener.getChatMessages(userId: user.id, actorId: actor.id, completionHandler: { chatMessageModels in
                    self.chatMessages = chatMessageModels
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
        if let listener = displayChatMessageListener, let actor = FoundrySocketIOManager.sharedInstance.actor, let user = FoundrySocketIOManager.sharedInstance.user {
            DispatchQueue.main.async {
                listener.sendChatMessage(userId: user.id, actorId: actor.id, message: message)
            }
        }
    }
}

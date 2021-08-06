//
//  ChatViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import Foundation

class ChatViewModel: ObservableObject {
    let foundryActor: ActorModel
    let user: UserModel
    var chatMessageListener: ChatMessageListener?
    @Published var chatMessages: [ChatMessageModel]?

    init(user: UserModel, foundryActor: ActorModel) {
        self.user = user
        self.foundryActor = foundryActor
        do {
            try chatMessageListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
        getMessageData()
    }

    func getMessageData() {
        if let listener = chatMessageListener {
            DispatchQueue.main.async {
                listener.getChatMessages(userId: self.user.id, actorId: self.foundryActor.actor.id, completionHandler: { chatMessageModels in
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
                listener.sendChatMessage(userId: self.user.id, actorId: self.foundryActor.actor.id, message: message)
            }
        }
    }
}

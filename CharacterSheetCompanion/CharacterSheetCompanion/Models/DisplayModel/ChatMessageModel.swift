//
//  ChatMessageModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import Foundation

struct ChatMessageModel: Codable, Identifiable {
    var id: String
    var speaker: String
    var userId: String
    var isCurrentUser: Bool
    var content: String
    var timestamp: Double
    var chatFlavor: String?
    var whisperUsers: [String]?
}

#if DEBUG
    extension ChatMessageModel {
        static let mockedData = [
            ChatMessageModel(id: "1", speaker: "John Doe", userId: "1", isCurrentUser: false, content: "Hello", timestamp: 1_628_547_498),
            ChatMessageModel(id: "2", speaker: "Me", userId: "2", isCurrentUser: true, content: "Hi", timestamp: 1_628_547_498),
            ChatMessageModel(id: "3", speaker: "John Doe", userId: "1", isCurrentUser: false, content: "How are you?", timestamp: 1_628_547_498),
            ChatMessageModel(id: "4", speaker: "John Doe", userId: "1", isCurrentUser: false, content: "Haha", timestamp: 1_628_547_498),
            ChatMessageModel(id: "5", speaker: "Me", userId: "2", isCurrentUser: true, content: "I'm well, how're you?", timestamp: 1_628_547_498),
            ChatMessageModel(id: "6", speaker: "Me", userId: "2", isCurrentUser: true, content: "Ready to play?!", timestamp: 1_628_547_498),
            ChatMessageModel(id: "7", speaker: "John Doe", userId: "1", isCurrentUser: false, content: "I'm well!", timestamp: 1_628_547_498),
            ChatMessageModel(id: "8", speaker: "John Doe", userId: "1", isCurrentUser: false, content: "Yeah, let's do this!", timestamp: 1_628_547_498),
            ChatMessageModel(id: "9", speaker: "Jane Doe", userId: "3", isCurrentUser: false, content: "Who's John?", timestamp: 1_628_547_498, chatFlavor: "I'm a chat flavor!", whisperUsers: ["Me"]),
            ChatMessageModel(id: "10", speaker: "Jane Doe", userId: "3", isCurrentUser: false, content: "I don't know John", timestamp: 1_628_547_498,
                             chatFlavor: "I'm also a chat FLAVOR!@@!!", whisperUsers: ["Me"]),
            ChatMessageModel(id: "11", speaker: "Me", userId: "2", isCurrentUser: true, content: "He's cool", timestamp: 1_628_547_498, whisperUsers: ["Jane Doe"]),
        ]
    }
#endif

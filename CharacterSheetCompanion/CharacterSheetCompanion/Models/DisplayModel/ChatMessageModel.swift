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

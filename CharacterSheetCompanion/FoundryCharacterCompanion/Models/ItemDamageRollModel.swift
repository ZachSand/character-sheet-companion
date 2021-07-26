//
//  ItemDamageModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/26/21.
//

import Foundation

struct ItemDamageRollModel: Codable {
    var actorId: String
    var itemId: String
    var critical: Bool
    var versatile: Bool
    var result: Int
}

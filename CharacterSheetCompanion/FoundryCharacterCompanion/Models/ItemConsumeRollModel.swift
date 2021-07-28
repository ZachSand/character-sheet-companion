//
//  ItemConsumeModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/28/21.
//

import Foundation

struct ItemConsumeRollModel: Codable {
    var actorId: String
    var itemId: String
    var consume: Bool
    var result: Int
}

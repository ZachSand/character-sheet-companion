//
//  AbilityRoll.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/15/21.
//

import Foundation

struct AbilityRollModel: Codable {
    var actorId: String
    var ability: String
    var advantage: Bool
    var disadvantage: Bool
    var isSave: Bool
    var result: Int
}

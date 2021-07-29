//
//  ItemAttackRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/21/21.
//

import Foundation

struct ItemAttackRollModel: Codable {
    var actorId: String
    var itemId: String
    var advantage: Bool
    var disadvantage: Bool
    var result: Int
}
